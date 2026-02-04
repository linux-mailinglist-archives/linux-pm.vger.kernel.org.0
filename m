Return-Path: <linux-pm+bounces-42031-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HvaEIK1gmnwYgMAu9opvQ
	(envelope-from <linux-pm+bounces-42031-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 03:57:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82027E10D7
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 03:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33AE4301DAD1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 02:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305DB2D8DC2;
	Wed,  4 Feb 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpBK/WE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380024336D
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173823; cv=pass; b=IRLRX+ocBtjHhDIh4PFId3qeEN/Rd9Zc4fCRoo9SAPz3R2YobUUgzdzItUSA2OmwajXs5f3lYv2vnYzeYYsae2V9yV+U7qMhUkyzHsZWEHe5e1Gaxdla6Z4+VNWMRIUa7ThAIlsmSej4ijJ60PqPF2ZT7KQiWGoCN/kyJ9w7u2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173823; c=relaxed/simple;
	bh=2XfUK7Q3/Hj7XOWCmfPlucaMa4l0nZSO2aOOONQHIV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaytsxWBdUHhl2zkqAHMA8u57idaw0zRX1DMpSiwpG/zxgfnHXhephG75WdXMrj4x4ahwhNAGfk054DCbGiv2ysfWtgfQBQgBBE0GjlR0yn5SFAd51G14fBY2+JJiHxesGypiemxRg5U/RePH/4Ht1v45XK6Efexr+z4EieGqzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpBK/WE/; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-503bf474fdfso59540501cf.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 18:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770173820; cv=none;
        d=google.com; s=arc-20240605;
        b=jWcYht4E5a3iQz90JGF4Dz3wSupwSAef6ydaTww1mEOj96cLo0C8g8AT7e4k0GSiZ8
         nYMnNL1ayVaADajS8BXcYuQTiMpko4UvFjb4F1XyPSZK7LypU+jOiXurWd4v0FfJA2nt
         crbZZ1bupbuxGWm7aFVI0arFRN0VwQgcVHy8BH2HbXWDSYtLrFHuEhML8xu7O7mr3eHv
         JHOfieTcdhdSaHWj0LvPsRmlfsCua3tJTashQxICidsfDf+4pYv57PzPlQhf0HjKvEdd
         fsgDbDB24aIrGkiApFT/yMWwJkyMIGVBKEbicQxq+UbaLQuU7M9L9o+eS7RQJ/WFbt/j
         PxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3qktFH8B48Z06akbK5h2YRzFT0VcS0FK1QEZfSWucys=;
        fh=3A+YfaT2lCHg2b57Gm3LtVRr2H564G6Hy1zUeZFyCV4=;
        b=QJn+5abHy1bQ1nhur+2lcGyTL+qHpw5e15dExrWXn9DJI5UFZ9UkKnPJijpR6lqGSG
         sSpIECHgjpdHBt1DeETE6oaVHtI/7hq0+ok/NWdDUl7clVsUzfBBBrMugn89bAWoxIqB
         hTDHCN0NeGFWBr2I/etPdCgBkoeDy2R9/T/zvySUwhAVNyPY8RqYNcIDEhTl2O5U4Ary
         cYUc5APu0/cJ1ayXbNEmbtp/uqM1KRohuezAIv4BaxAPncbi3JQc4ZQdHDG7xQPZd/uY
         WM7sFhg3g5xpAn02k89zhckdgXxayxeo/3TXONuQ904Iq6oDarQ8x/rJzyrgqMuZzu1Q
         2TUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770173820; x=1770778620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qktFH8B48Z06akbK5h2YRzFT0VcS0FK1QEZfSWucys=;
        b=cpBK/WE/3IZF9LqVb9opaN2TCpj/4w8tYj2AigSJbI+a52ZrqfvrgdrHjVYrxiDnay
         tbS3zY+dKbN4L+yqy03X8EKvjLf/tNm2kmq1jcuyTw1J/KwSFQvsEtlGQpiGvtRarsaR
         0MTpE+2m3AaTp+wPwRhSeAkL+gi/jZ5NlKt7WiTugTu5Yv/Qz2v0g15bbooWY0dXSase
         wgQNzix9ieQgtym0+RvTlri+NXBpYZMtP3vFuwUPcO50kiV1nt6IJRcd7cIj73tGHOL6
         08f8IPuDvy+oQGzs2FjTLVUmY7CshUFPs9+jMSeLMV45g5qpU+EbAY9F1XrltoFqV//B
         lhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770173820; x=1770778620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qktFH8B48Z06akbK5h2YRzFT0VcS0FK1QEZfSWucys=;
        b=STQ/qxdhkWX/T7bENC9rNHMAtJt1gZgMb/BgwN+e690NnPTOMflGEhGA7NfMaCjRvF
         CmNEM2d8FiPYwBGnKxhmNBUM0AN7TJEHUUwfEKaGwpYo68IuLArbBLhxXj2rB6yBhLNp
         HaTX+XF8tYUl+qmZtN+qtVmkOJoc0YsyKF2uRxq9L9i6ZHNrI4nkCH06mSJYZj36KMyL
         PWf0cxVV0AwxKDeMC7vKaZW231StDy1TTReZ16CakSPOZJ/8RW8llTdiVGrTOt90pLF2
         p9Bhitzq0eCO5uEL+/avca0oo6z//Ba62nEXyw9CZqKs339s/o8UX767Xkg3ELxFwceU
         Usyg==
X-Gm-Message-State: AOJu0YxArRfvagvdCQQv3inlO84IBFhwX4ehs8AsazMrIbINiSY1Bk4H
	c/pAS4lqTny4JtZPAfWNqekLzxo9Gzhli5vKvZz6fKGEMvsl+fsDx1D5lVMie1BXGOWnh/OOlPC
	ic9yxx4sYpkUYf+0jTy7adPL0cDgmPxI=
X-Gm-Gg: AZuq6aKeYVzaVOHPVSfqqgeLdHgSrJzDA3WUcYK/EtlaM52OYisKz+QK3grC6jXCywx
	tks2WK7arZPVJ5c817qkCxS+iiz8M6epoljz/5Vrxw+uRVBbxFPa0i49Lwc5J+9cMVwhCCn2Lyo
	zNqxvr2OAfiU6dNUi/+KxshWhV/lcM5iDA8IH1inrMpd7BUWCUwHJUxyiKBQUjp3wwGZMn7OxsX
	u7aKpFtuSGq35YOxQPnFm9qCOskDLUempNMs6pnxGH/D7I41WXA78hG62GSsy12ghSV/O+n
X-Received: by 2002:a05:622a:1997:b0:4ed:6e70:1ac4 with SMTP id
 d75a77b69052e-5061c1a4bcfmr18535001cf.42.1770173820341; Tue, 03 Feb 2026
 18:57:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12852589.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12852589.O9o76ZdvQC@rafael.j.wysocki>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 4 Feb 2026 10:56:49 +0800
X-Gm-Features: AZwV_Qg04NAxJO-oPae_AheRYEDvRGMKvZmplU1aD6ywMWk2QNbytAOHIOPXNDQ
Message-ID: <CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Clear device async state upfront
 during suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42031-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewenyan94@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82027E10D7
X-Rspamd-Action: no action

Hi Rafael,

On Wed, Feb 4, 2026 at 4:38=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In all of the system suspend transition phases, async state of all
> devices needs to be cleared before starting async processing for any of
> them because the latter may race with power.work_in_progress updates for
> the device's parent or suppliers and if it touches bit fields from the
> same group (for example, power.must_resume or power.wakeup_path), bit
> field corruption is possible.
>
> Rearrange the code accordingly.

Could we use the following patch:

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 98a899858ece..afcaaa37a812 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -681,10 +681,10 @@ struct dev_pm_info {
        struct list_head        entry;
        struct completion       completion;
        struct wakeup_source    *wakeup;
+       bool                    work_in_progress;       /* Owned by
the PM core */
        bool                    wakeup_path:1;
        bool                    syscore:1;
        bool                    no_pm_callbacks:1;      /* Owned by
the PM core */
-       bool                    work_in_progress:1;     /* Owned by
the PM core */
        bool                    smart_suspend:1;        /* Owned by
the PM core */
        bool                    must_resume:1;          /* Owned by
the PM core */
        bool                    may_skip_resume:1;      /* Set by subsystem=
s */

Due to byte alignment, the size of struct dev_pm_info remains unchanged,
while also preventing concurrency issues between work_in_progress and
other variables.
Additionally, with this modification, there=E2=80=99s no need to traverse t=
he
device list twice.


BR
---
xuewen

>
> Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending c=
hildren")
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronou=
s")
> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.ya=
n@unisoc.com/
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1527,11 +1527,20 @@ static int dpm_noirq_suspend_devices(pm_
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> +        * Clear the async state for all devices upfront to prevent the
> +        * power.work_in_progress updates from racing with power.must_res=
ume
> +        * updates carried out by dpm_superior_set_must_resume(), since t=
hese
> +        * flags belong to the same group of bit fields and they should n=
ot be
> +        * updated at the same time without synchronization.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entr=
y)
> +               dpm_clear_async_state(dev);
> +
> +       /*
>          * Start processing "async" leaf devices upfront so they don't ne=
ed to
>          * wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entr=
y) {
> -               dpm_clear_async_state(dev);
>                 if (dpm_leaf_device(dev))
>                         dpm_async_with_cleanup(dev, async_suspend_noirq);
>         }
> @@ -1732,11 +1741,20 @@ int dpm_suspend_late(pm_message_t state)
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> +        * Clear the async state for all devices upfront to prevent the
> +        * power.work_in_progress updates from racing with power.wakeup_p=
ath
> +        * updates carried out by dpm_propagate_wakeup_to_parent(), since=
 these
> +        * flags belong to the same group of bit fields and they should n=
ot be
> +        * updated at the same time without synchronization.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry=
)
> +               dpm_clear_async_state(dev);
> +
> +       /*
>          * Start processing "async" leaf devices upfront so they don't ne=
ed to
>          * wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry=
) {
> -               dpm_clear_async_state(dev);
>                 if (dpm_leaf_device(dev))
>                         dpm_async_with_cleanup(dev, async_suspend_late);
>         }
> @@ -2023,11 +2041,20 @@ int dpm_suspend(pm_message_t state)
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> +        * Clear the async state for all devices upfront to prevent the
> +        * power.work_in_progress updates from racing with power.wakeup_p=
ath
> +        * updates carried out by dpm_propagate_wakeup_to_parent(), since=
 these
> +        * flags belong to the same group of bit fields and they should n=
ot be
> +        * updated at the same time without synchronization.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)
> +               dpm_clear_async_state(dev);
> +
> +       /*
>          * Start processing "async" leaf devices upfront so they don't ne=
ed to
>          * wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)=
 {
> -               dpm_clear_async_state(dev);
>                 if (dpm_leaf_device(dev))
>                         dpm_async_with_cleanup(dev, async_suspend);
>         }
>
>
>
>

