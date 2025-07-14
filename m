Return-Path: <linux-pm+bounces-30775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFFDB039BC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15417A9558
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5E23C38C;
	Mon, 14 Jul 2025 08:44:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322EA23BCF1;
	Mon, 14 Jul 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482687; cv=none; b=Pt/ml41qe1jrTDxNXfhWtX4rgjOG+CMuFkjUugxEoveJHyowySzbA7j8Ceyi37KrKfoiQHGQVktm0UPLWEdTyT8GUxEKqb1LzNLNSEif422rOO3RyJ1wCR7wtQewqnM1ZZf8XfT+XqIL8bx+Tk+/u8JUulZ7pmHRmabjepe211o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482687; c=relaxed/simple;
	bh=mYn5GwyqteX0TZbxTHa/c2kP6LZJ3stZ6wquAT36K/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUU9HudIkRepOdA+LQYlWomyYKbuAG4gDR2pnLtd8kxbsGkxTu9Db/eoLhj7oitpbaKLzNQhP/HvcSG4+78kWO3xoeKZpcVZBl3gL8PtF1GEF67ykiXAkPmuC6fikYG9rS5eD/jhyDFwqIDXxZtOY8YtBQ2QTbERVSMGB+RG0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c12b0d66608e11f0b29709d653e92f7d-20250714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fc2dc1f4-2804-4165-b887-a576b37a684b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:9781c746e807f08d5912cf29754026f2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c12b0d66608e11f0b29709d653e92f7d-20250714
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1703760224; Mon, 14 Jul 2025 16:44:29 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id DF229E008FA3;
	Mon, 14 Jul 2025 16:44:28 +0800 (CST)
X-ns-mid: postfix-6874C36C-823439724
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 599D7E008FA2;
	Mon, 14 Jul 2025 16:44:27 +0800 (CST)
Message-ID: <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn>
Date: Mon, 14 Jul 2025 16:44:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: suspend: clean up redundant
 filesystems_freeze/thaw handling
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Just a gentle ping on this patch.

I realized I forgot to mention an important motivation in the changelog:
calling filesystems_freeze() twice (from both suspend_prepare() and=20
enter_state()) lead to a black screen and make the system unable to resum=
e..

This patch avoids the duplicate call and resolves that issue.

=E5=9C=A8 2025/7/12 11:08, Zihuan Zhang =E5=86=99=E9=81=93:
> The recently introduced support for freezing filesystems during system
> suspend included calls to filesystems_freeze() in both suspend_prepare(=
)
> and enter_state(), as well as calls to filesystems_thaw() in both
> suspend_finish() and the Unlock path in enter_state(). These are
> redundant.
>
> - filesystems_freeze() is already called in suspend_prepare(), which is
>    the proper and consistent place to handle pre-suspend operations. Th=
e
> second call in enter_state() is unnecessary and removed.
>
> - filesystems_thaw() is invoked in suspend_finish(), which covers
>    successful suspend/resume paths. In the failure case , we add a call
> to filesystems_thaw() only when needed, avoiding the duplicate call in
> the general Unlock path.
>
> This change simplifies the suspend code and avoids repeated freeze/thaw
> calls, while preserving correct ordering and behavior.
>
> Fixes: eacfbf74196f91e4c26d9f8c78e1576c1225cd8c ("power: freeze filesys=
tems during suspend/resume")
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>   kernel/power/suspend.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index bb608b68fb30..8f3e4c48d5cd 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -384,6 +384,7 @@ static int suspend_prepare(suspend_state_t state)
>   		return 0;
>  =20
>   	dpm_save_failed_step(SUSPEND_FREEZE);
> +	filesystems_thaw();
>   	pm_notifier_call_chain(PM_POST_SUSPEND);
>    Restore:
>   	pm_restore_console();
> @@ -593,8 +594,6 @@ static int enter_state(suspend_state_t state)
>   		ksys_sync_helper();
>   		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>   	}
> -	if (filesystem_freeze_enabled)
> -		filesystems_freeze();
>  =20
>   	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[stat=
e]);
>   	pm_suspend_clear_flags();
> @@ -614,7 +613,6 @@ static int enter_state(suspend_state_t state)
>   	pm_pr_dbg("Finishing wakeup.\n");
>   	suspend_finish();
>    Unlock:
> -	filesystems_thaw();
>   	mutex_unlock(&system_transition_mutex);
>   	return error;
>   }
Thanks,
Zihuan Zhang

