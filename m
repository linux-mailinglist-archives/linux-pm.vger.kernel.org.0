Return-Path: <linux-pm+bounces-10642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD5927FEC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 03:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DB51C21CD4
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075D1F50F;
	Fri,  5 Jul 2024 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWZ3cyr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE1848A;
	Fri,  5 Jul 2024 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144536; cv=none; b=rQR0qheVG9Zcalp4PQcOIvf/cy4G9NwFJLW+/GF2W5bPpVyW9QnXdrl07Z8yB8FiFpHKAOQVgBdb6/F7OiFE48sFWagRV01HF7tSUCDSydj8dVbZN0wKxyssyIAiGHR/StnCqmND1E3ZmWZZ7dxL5geT2AINYAlKaeZDNY4ak9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144536; c=relaxed/simple;
	bh=0D07LHAuhhUTF8PFmdgBLlE7Wo0dLVb51mBbu1HxwUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c39l1tqYm59K/1gGHmhRdU1zX81WhMy0aJk/cuPcaBwX5ZagMRyHAZf/i7Ck3PpDr/0/WgIfPmbQs+LMVEjGJgmH+JgU8Fwu+dx8B2hf9nlffumzmbODtKdD119eLQzP3mrtaiaFctm4goU5e0b3dKOVFculYb++zC3ZLuuUnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWZ3cyr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16279C3277B;
	Fri,  5 Jul 2024 01:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144536;
	bh=0D07LHAuhhUTF8PFmdgBLlE7Wo0dLVb51mBbu1HxwUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWZ3cyr9YnRQMnZhzLP9jJLxSHLjRfogDBprSaFxMbke0qmX+aSZyZhZlYmljrGI6
	 yV+pa+5jjjxKmPyzz5fKdqWdAgPJ56Kvd8CLWWl602mid+IdsoTmoy0Dsw8CyLMpao
	 3sNC+iHe2icjtFQFXOFJ/Yac+Bt6290hN2mbCKIZeA09i5OI08y17285J5DtsCO1Jk
	 thYvotCStwHBVioNRLL0qLC2J8aRWPB07gbEpdKGWUd2ePOnHRGoGt75ArI5p87c8P
	 m4DO5PJI7G1lBT5w5ZdY/EdORiND0BFhEH/xNhmqFsnO/Z05tjue9vLcG//cpOHLQ0
	 68bbZCmFZ1taw==
Date: Fri, 5 Jul 2024 01:55:31 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>, chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: cros_charge-control: Fix signedness bug
 in charge_behaviour_store()
Message-ID: <ZodSk4PRanMnT9-Z@google.com>
References: <ZoWKEs4mCqeLyTOB@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoWKEs4mCqeLyTOB@stanley.mountain>

On Thu, Jul 04, 2024 at 10:20:03AM -0500, Dan Carpenter wrote:
> The C standard is vague about the signedness of enums, but in this case
> here, they are treated as unsigned so the error handling does not work.
> Use an int type to fix this.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

Thanks!

[1/1] power: supply: cros_charge-control: Fix signedness bug in charge_behaviour_store()
      commit: 4baf1cc54433ff7c6e5178517bc8768001416681

