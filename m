Return-Path: <linux-pm+bounces-41185-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIVqAPnbb2n8RwAAu9opvQ
	(envelope-from <linux-pm+bounces-41185-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 20:48:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 714934AB84
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 20:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 762CE5CEABE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B20337B97;
	Tue, 20 Jan 2026 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLidT+oS"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22843382F9
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927877; cv=none; b=LBYdmkxPvog2xkvMjt2UEJobhKhpd7ksa///fMoeNdsW316YDe4M2KpAdRmCGsp226vc4QF30RVu2WZKCSmy8RyQuWE4Xh2iQUDG4M0rwvhh0CLFiZRD6OzEb1bIKn0kDNizSaT3FESVkbWRU/rWWTT40+UvCbUywyaxzCq8/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927877; c=relaxed/simple;
	bh=H5jUaq6TO9WHZm4XEIgKRpBBhzYpVtxFin3BW6cKEzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toiHTDar+wiOMZt+DlYw+u1MOusxVb3Hj4Qsrb1gHUEjQCqteXaV0aaWeax92XuxwyWaFCszayZKyLgyh2xZpLgSHvE+1m4p1SkEZPoUxZXxqm/6b5yPozXL+dO68IbTcTQ6ymjPZ7tMM9JRy3TAW5loVgst38P7It+Kg9UtcQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TLidT+oS; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43cb31d5-1423-4354-8eb1-68afbac622da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768927861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vDNXH6hz9GY1gVM64SCoYcMQRc3wsyeCa6a+Ouc5vs=;
	b=TLidT+oSdyLY34sS6yohVQvMtssO+Z+UHxqVjWSboTRv2vusLvKHWuKtwaN0db/XF2MAhv
	n2iHkucZVyfVB0147UeN3QeBa/gnJdjsvOLAOqrde2/7K+tbKI7waC8dgvLRmdBTEsr03r
	nsRJxHnCNX0hcyt4U9XWPDmYl/3Hgcw=
Date: Tue, 20 Jan 2026 17:50:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ASoC: SDCA: Add NO_DIRECT_COMPLETE flag to class driver
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com, rafael@kernel.org,
 linux-pm@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com
References: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20260115131727.373738-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,vger.kernel.org,opensource.cirrus.com];
	TAGGED_FROM(0.00)[bounces-41185-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre-louis.bossart@linux.dev,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 714934AB84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/15/26 14:17, Charles Keepax wrote:
> The SDCA class driver currently expects the device will be fully powered
> down on system suspend but not on runtime suspend. This is typically
> required as when audio is not active (ie. runtime suspend) jack detect
> is expected to still function, but when the whole system is hibernated
> there is no need to recognise audio jack events. This means the class
> driver needs to always be informed of a system suspend, so the direct
> complete optimisation (where PM will skip calling system suspend if the
> device is runtime suspended) is not appropriate for the SDCA class
> driver.
> 
> Add the NO_DIRECT_COMPLETE flag to prevent this optimisation from
> running against this driver.

Humm, this flag makes sure the class driver .suspend method is called, but does the core also force a pm_runtime resume before?

In other words, what is the state of the device when the system suspend routine is invoked by the PM core when this flag is set?

FWIW, we had a similar problem on the Intel side, and we used the .prepare method to force a pm_runtime resume. If the host was pm_runtime suspended, then we'd bring it back to full power before the system suspend. It may seem overkill but it's required at the hardware level, a system suspend with the clock already stopped isn't supported.
If the PM core guaranteed the device state was resumed by adding this flag, then the Intel folks could remove quite a few lines of code.

link: https://github.com/thesofproject/linux/blob/ec0e6c69113f4b342ee8eabec286dea33d98a7cc/drivers/soundwire/intel_auxdevice.c#L568

Going back to this SDCA driver, if the PM core does NOT change the pm_runtime state, then should the class driver perform a full pm_runtime resume and then do the expected system suspend sequence?

Sorry if I am splitting hair, in the past we played with these PM flags and always understood them in the wrong way...
 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  sound/soc/sdca/sdca_class_function.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/sdca/sdca_class_function.c b/sound/soc/sdca/sdca_class_function.c
> index 0afa41c1ee93c..98fd3fd1052b4 100644
> --- a/sound/soc/sdca/sdca_class_function.c
> +++ b/sound/soc/sdca/sdca_class_function.c
> @@ -377,6 +377,8 @@ static int class_function_probe(struct auxiliary_device *auxdev,
>  	if (ret)
>  		return ret;
>  
> +	dev_pm_set_driver_flags(dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> +
>  	pm_runtime_set_autosuspend_delay(dev, 200);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_active(dev);


