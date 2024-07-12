Return-Path: <linux-pm+bounces-11033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D792F951
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6941828405C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B7715957E;
	Fri, 12 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnwFS+fn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9F1422C3;
	Fri, 12 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782448; cv=none; b=gB8qR9nh0k6vFL6aH8CdvOq2ttomJ5lvFrWM7zc9yhsq6XBeHSxJe+8FYFjkLCH4PExxirTZw95BAYYD/UO2yvowy8PM5oQ/5hoo6i7fydmf1WNn4xFxZLOqNezRUKnuZuleuySBA2/NU/pOur+yEI5i4jSYARXidssfpTcaGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782448; c=relaxed/simple;
	bh=J5B4V+GxjTUk/uTZIdgig3t7RPhLCkFHCun4ASHiAlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blk+Iv6qRIhxGSELub5efZ2ynGyVJHf6+dXXVVI+7RjRb66BmOCKXx/Fn7sA0f9pJtp3eQjJG4DHrDFctjroHea+sm9LZH737GVqiFDXTXCFFZ/lM86UgjIJaTRDy6Z69k+xKmlXrLILWgTK1GhQDCZpbrEGqtE8jEFotlAHrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnwFS+fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C2BC32782;
	Fri, 12 Jul 2024 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720782448;
	bh=J5B4V+GxjTUk/uTZIdgig3t7RPhLCkFHCun4ASHiAlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnwFS+fnNraQw6n/j+xWTvycP5JpS8ghclHM/iG/fZx4sNZ05NqQo6pFCk0t8KGjj
	 FnEqxNlq18vGbdPl2UpxLhTU+M6Qza5B3MWMlGGM5/UNlCqIwtNj4tDSBn/XyRUzo8
	 XKqfboBT0h1xCkl6Z/auKnNT5pz8WEA0fu8KTwD9NijCYwcQepAb2836nPUjOi0P2i
	 DlXGwVmSwCZuoUb0kV7IeA7IOMKUFanGXipOU/A4ElTTSfmM9RNKkMfjjV8ycwitPV
	 wg1xtSZ4KifdFQdISyMhxdW/IPBRkIyyKtte6Q+IYjmTBH2AeLInOXUtrF5v4fuWfv
	 fHYrM1rhgIWaA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sSE7b-000000001aF-1Odx;
	Fri, 12 Jul 2024 13:07:27 +0200
Date: Fri, 12 Jul 2024 13:07:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Ignore extra __le32 in info
 payload
Message-ID: <ZpEOb-fOc04bknxy@hovoldconsulting.com>
References: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>

On Fri, Jul 12, 2024 at 12:00:03PM +0200, Stephan Gerhold wrote:
> Some newer ADSP firmware versions on X1E80100 report an extra __le32 at the
> end of the battery information request payload, causing qcom_battmgr to
> fail to initialize. Adjust the check to ignore the extra field in the info
> payload so we can support both old and newer firmware versions.
> 
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Can confirm that the old fw still works (didn't really look at the
patch):

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

