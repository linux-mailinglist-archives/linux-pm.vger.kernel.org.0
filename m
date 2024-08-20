Return-Path: <linux-pm+bounces-12533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A31957F26
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6122E281E34
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C1E16C877;
	Tue, 20 Aug 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omx72tnu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A88152165;
	Tue, 20 Aug 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137971; cv=none; b=GkUtsPDvF2tyTd/+uZO/wAHjorB+PUszO0H70hMlDbUCFYBmoyDinQml2Nbb9KqQ5pi11yFlxLV8Am+wiaaKM10Exlnci6JGJgF9btmLunp66AAduGuJTwkfxtzS74ht2MbSO586yqztNlEvqIOc9TQxsg4GhxoH/J3kGf1lyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137971; c=relaxed/simple;
	bh=05juWIN/pOOlKh+0AWNVcA4j6ejO1nrcxfu3RKQyvM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6UUuGbYQc8YgvnP9Av65X+IGcE0usod0Kfz1nB1+5Pqw4hDet8FizCUR2tgydDmAIpeyorYet0qv2RPhMv/cP7mXqAueM76wA33qTor4HCdgIk/A1ZR6ZzPFPSFLFjvHwHJcqlx5TwXR0YNyGkL5VAlXWaPDxTIVTc/3vVDS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omx72tnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03398C4AF0B;
	Tue, 20 Aug 2024 07:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724137971;
	bh=05juWIN/pOOlKh+0AWNVcA4j6ejO1nrcxfu3RKQyvM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Omx72tnu8bxN1JJKJ5zMkVpZLpyJrh/QDA+GUAMptshVynAl51/WGblFvcJC6IIUM
	 vYa2RbvPHtthhJ78bTlcLNDlHg/rnNxL0orDQiPXyB7kqzGWsmNXQq3tc/5rVUXADp
	 rOVEC+bBabF0VgivLprOVVPcPmDAsuecFZ/anURv4TLmKDioVPnkJIsXW/2Y9m3l7q
	 GicxakTZod9ArkV13vuxFf+jYFSzLFH1zN1btw3KcXX9AEtgQ5iLD1qBrHQ4joTi36
	 7OWebZCB2rMNNRDJQjoqNbB8S4R6h/FvOaoT5W/teIZxsD7S61Vjy9ksoWge4HzhqN
	 DoPIEPZZvSJgQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sgJ2v-000000003f5-1Mye;
	Tue, 20 Aug 2024 09:12:49 +0200
Date: Tue, 20 Aug 2024 09:12:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Amit Pundir <amit.pundir@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] soc: qcom: pmic_glink: v6.11-rc bug fixes
Message-ID: <ZsRB8fk1_P7XPtQS@hovoldconsulting.com>
References: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>

On Mon, Aug 19, 2024 at 01:07:44PM -0700, Bjorn Andersson wrote:
> Amit and Johan both reported a NULL pointer dereference in the
> pmic_glink client code during initialization, and Stephen Boyd pointed
> out the problem (race condition).
> 
> While investigating, and writing the fix, I noticed that
> ucsi_unregister() is called in atomic context but tries to sleep, and I
> also noticed that the condition for when to inform the pmic_glink client
> drivers when the remote has gone down is just wrong.
> 
> So, let's fix all three.

> Changes in v2:
> - Refer to the correct commit in the ucsi_unregister() patch.
> - Updated wording in the same commit message about the new error message
>   in the log.
> - Changed the data type of the introduced state variables, opted to go
>   for a bool as we only represent two states (and I would like to
>   further clean this up going forward)
> - Initialized the spinlock
> - Link to v1: https://lore.kernel.org/r/20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com
> 
> ---
> Bjorn Andersson (3):
>       soc: qcom: pmic_glink: Fix race during initialization
>       usb: typec: ucsi: Move unregister out of atomic section
>       soc: qcom: pmic_glink: Actually communicate with remote goes down

Tested-by: Johan Hovold <johan+linaro@kernel.org>

