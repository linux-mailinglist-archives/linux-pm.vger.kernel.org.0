Return-Path: <linux-pm+bounces-30374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4407EAFCDFC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8AE1888574
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC02DF3C6;
	Tue,  8 Jul 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3O72sxg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C514883F;
	Tue,  8 Jul 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985580; cv=none; b=INZW9f32xFbWcOudQK1fGbxjKnVFYlwCC3hDGnKtVtu0yYzFSTr2C9kdpEkbKN4btaAgpKGbmd3gvGwo1Fc7G+su5ri3TdN2q7/bzEKlAirce/DQDKDo6iwW5h2kTxMu1MW2V9R0BB2ajLulFmVS2p3TgP82SQoLV1OvmwPmT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985580; c=relaxed/simple;
	bh=g7JNnaXSPMt+VqEG9a7P7H3phrBTW8jOu04WbuFibsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HImG9zkPutKetwnqre88vPbctGSSGaCzLc0sVvHCcbf8YXV8HiQ19XormqHG9eFGheAB5p2SpW/vJSUiT+kNd3tG2m/rfhpqn38SAEU8tMke4YVW4Y0Qpq71FvtIN64AH+MTYvP6WphNmdsjUFd0XdcU8i0W0/9RdjUxTJ69LEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3O72sxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5BCC4CEF9;
	Tue,  8 Jul 2025 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985580;
	bh=g7JNnaXSPMt+VqEG9a7P7H3phrBTW8jOu04WbuFibsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s3O72sxg3nj0vXCiW+P7HVPpEje5HvkAMPnuzmWE7FHX8DLSeU2Diy6jU/2hGriOX
	 VAat9E+ziM8nyzy9vkXNadkaajXVkwI5XwWy1tnrwmeob4SgnpkH7HxU3HcrmPyxdd
	 2P/qTalhQJ/ByNmu8cfyYT9hICeNGjC/ZcWaIAZ7C73IZ4y8dDHG5tv7AICCCLkEQI
	 mKuBVwNDVieoaJwXx05nu1aqXLoG0f2rQybj9as/KpVSOo/jnrJJL7UYKsaZZuo5fO
	 E0n9ewrnxfGW7qfU7qR+3+kSKhMBG4i1gJ7KllGCRUqOUMh7A/CUyYfHjzJTSAyLP6
	 OnILmV3ioYMeg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c09f8369cso1469229a34.3;
        Tue, 08 Jul 2025 07:39:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhaM6aq5cII4hLC/uZY5NbuKiBNV2QQAtYyrXdvNNMJHUFLxoQp42FE2yZ5phXPEuBaj6Is+l09O0BzMU=@vger.kernel.org, AJvYcCXLyvlTE/Yk0tk1h7Yvs4j79hOhEXsC33f0AiTammTt+1mzMMLlPiUfixz0SI25fQEYMb/9DXZbcm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf4Wax2JQOyM0IX1Ix9mXmQRgAraZpBr63qZsC7FQvbuB5/C+D
	lAxLa/jJysn0R3yh245TRuvn6O8VhWN1JKrPQGH3ga9vnXMuqjR7NECi6yGwloWi5Me58xs4Juh
	S9w0vpDxrHROWDFLZjPiwTpj3Ua987dM=
X-Google-Smtp-Source: AGHT+IHiTi+tK7OBKN3ciDaO2n9BCiXei6vti+iRh6w6s5ITlTagv0S3T9OaABT6TshT1h/8Lt9SWI8UCBcRgqIfg+A=
X-Received: by 2002:a05:6808:308c:b0:40a:f48f:2c10 with SMTP id
 5614622812f47-4125cd1b519mr20316b6e.10.1751985579249; Tue, 08 Jul 2025
 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708074248.1674924-1-guoqing.zhang@amd.com>
 <20250708074248.1674924-5-guoqing.zhang@amd.com> <1fa50a8e-9942-45c4-bef0-f31c23ef9923@amd.com>
In-Reply-To: <1fa50a8e-9942-45c4-bef0-f31c23ef9923@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jul 2025 16:39:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4BuFi_WPPvW64=42Ww=tM8xwpX6gPz8_HX8fJE_Wv1Q@mail.gmail.com>
X-Gm-Features: Ac12FXzvqGDKTtz6zV1G6dpp5vC1FXf7sqbpxq5Jl57O26uN2XAqE-cZGhzEN-A
Message-ID: <CAJZ5v0j4BuFi_WPPvW64=42Ww=tM8xwpX6gPz8_HX8fJE_Wv1Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] PM: hibernate: add new api pm_transition_event()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, ray.huang@amd.com, matthew.auld@intel.com, 
	matthew.brost@intel.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, lijo.lazar@amd.com, 
	victor.zhao@amd.com, haijun.chang@amd.com, Qing.Ma@amd.com, 
	Owen.Zhang2@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:37=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/8/2025 3:42 AM, Samuel Zhang wrote:
> > dev_pm_ops.thaw() is called in following cases:
> > * normal case: after hibernation image has been created.
> > * error case 1: creation of a hibernation image has failed.
> > * error case 2: restoration from a hibernation image has failed.
> >
> > For normal case, it is called mainly for resume storage devices for
> > saving the hibernation image. Other devices that are not involved
> > in the image saving do not need to resume the device. But since there's
> > no api to know which case thaw() is called, device drivers can't
> > conditionally resume device in thaw().
> >
> > The new pm_transition_event() is such a api to query if thaw() is calle=
d
> > in normal case. The returned value in thaw() is:
> > * PM_EVENT_THAW: normal case, no need to resume non-storage devices.
> > * PM_EVENT_RECOVER: error case, need to resume devices.
> >
> > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> > ---
> >   drivers/base/power/main.c |  5 +++++
> >   include/linux/pm.h        | 16 ++++++++++++++++
> >   2 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 40e1d8d8a589..7e0982caa4d4 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -62,6 +62,11 @@ static LIST_HEAD(dpm_noirq_list);
> >
> >   static DEFINE_MUTEX(dpm_list_mtx);
> >   static pm_message_t pm_transition;
> > +int pm_transition_event(void)
> > +{
> > +     return pm_transition.event;
> > +}
> > +EXPORT_SYMBOL_GPL(pm_transition_event);
> >
> >   static int async_error;
> >
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 78855d794342..d1cb77ede1a2 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -657,6 +657,22 @@ struct pm_subsys_data {
> >   #define DPM_FLAG_SMART_SUSPEND              BIT(2)
> >   #define DPM_FLAG_MAY_SKIP_RESUME    BIT(3)
> >
> > +/**
> > + * pm_transition_event() - Query the current pm transition event value=
.
> > + *
> > + * Used to query the reason why thaw() is called. It will be one of 2 =
values:
> > + *
> > + * PM_EVENT_THAW: normal case.
> > + *           hibernation image has been created.
> > + *
> > + * PM_EVENT_RECOVER: error case.
> > + *           creation of a hibernation image or restoration of the mai=
n memory
> > + *           contents from a hibernation image has failed.
>
> I don't believe this documentation is complete.  In the use in this
> series those are two events used, but as this is now exported this might
> be used by other callers later which could use it for other PM_EVENT_*.
>
> So because of this I think it's best to convert the comment in
> include/linux/pm.h to kdoc and then reference that from this kdoc.

+1

> > + *
> > + * Return: PM_EVENT_ messages
> > + */
> > +int pm_transition_event(void);
> > +
> >   struct dev_pm_info {
> >       pm_message_t            power_state;
> >       bool                    can_wakeup:1;
>

