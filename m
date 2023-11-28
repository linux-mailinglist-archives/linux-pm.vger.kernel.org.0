Return-Path: <linux-pm+bounces-327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D17FAFAE
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0990A1C20AC5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C385186D;
	Tue, 28 Nov 2023 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2907BD;
	Mon, 27 Nov 2023 17:40:08 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1fa37df6da8so1186082fac.2;
        Mon, 27 Nov 2023 17:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701135608; x=1701740408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KMijVoZzKjmnAsmxupu7gb2DhrWpe//b9T4lGH4FwY=;
        b=jExPtyAWDITjC35tZOtKw0MnzoBfV4eroRXZYXcJVnBUOvUjeR/UEdCI7jjxj7ViWZ
         KZOmEK2nS0RwzyH45TYzB/BYQv7mJQd+XUV8QyEHx9qfrRsXPb05rD/7NbD5dKZDJNP9
         pm0rDB+g296vpV/LkjoiGL77cEPmxVMuBCmv3eZOGcy8qfIFbHXbwp0u+7yKla4ZQrY8
         bbkNXdw273rL+Ynie7JwpqDMRwLDiJdDhROXfQ8iE92sHQTq825uML3W4kIKQsx1YgHr
         v8mrwL6oCSv0NwVrMg2iY/t4qFqQslmDljGYYXClk6TttpNQjuxbgkLWEzdbs5bhf+uU
         0VFw==
X-Gm-Message-State: AOJu0Yx8cAsGw7Y7aIhNDKJc9w1VXyl+370TK8UrYsQhJGIBJIk2bUoD
	yJ0Amj6RVh3eR4dZELabPm/dWYQyi+zE+RRrDuOaOnpftPE=
X-Google-Smtp-Source: AGHT+IF2SsjExQsB/NHhZaU7EPVIoJQYuKioTorE0GXNez6nQUnzk/cFrZt3ZhgCVyn3kk8ec2GS517W3vmuiKfFEqU=
X-Received: by 2002:a05:6870:5a8b:b0:1f0:8122:554c with SMTP id
 dt11-20020a0568705a8b00b001f08122554cmr13274814oab.45.1701135608186; Mon, 27
 Nov 2023 17:40:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <002801da0da1$adb83fc0$0928bf40$@telus.net>
In-Reply-To: <002801da0da1$adb83fc0$0928bf40$@telus.net>
From: Len Brown <lenb@kernel.org>
Date: Mon, 27 Nov 2023 20:39:57 -0500
Message-ID: <CAJvTdKmJRsWzr8MSZdUv+1AA8AXBAoMF_CaNDAJE5EgThP5+EA@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Fix Bzy_MHz calculation equation
To: Doug Smythies <dsmythies@telus.net>
Cc: Peng Liu <pngliu@hotmail.com>, Wyes Karny <wyes.karny@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liupeng17@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peng Liu,
Thanks for the close read of the documentation, and the patch.
I've applied it, though I re-wrote the commit message (below) to make
it clear it is a documentation fix, as the code was already correct.

thanks,
-Len

ps. I would have replied to your original e-mail, but there was a
period where gmail dropped mail due to space limitations.
No worries, as Doug said, everything is in patchwork.


    tools/power turbostat: Fix Bzy_MHz documentation typo

    The code calculates Bzy_MHz by multiplying TSC_delta *
APERF_delta/MPERF_delta
    The man page erroneously showed that TSC_delta was divided.

On Thu, Nov 2, 2023 at 11:31=E2=80=AFAM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> Hi Peng and Wyes,
>
> Just for your information about your recent "ping"s about your turbostat =
patches:
>
> Please be aware that there is rarely any reply. There tends to be about 2=
 turbostat updates released per year. Your patches are in patchworks [1], a=
s are some others, including an old one of mine from 2023.04.03
> Eventually there will be an update, and hopefully it will include all our=
 patches.
>
> [1] https://patchwork.kernel.org/project/linux-pm/list/?series=3D&submitt=
er=3D&state=3D&q=3D&archive=3D&delegate=3D107
>
> ... Doug
>
> On 2023.10.29 08:12 Peng Liu wrote:
>
> > Ping
> >
> > On 2023/10/7 13:46, Peng Liu wrote:
> >> From: Peng Liu <liupeng17@lenovo.com>
> >>
> >> To calculate Bzy_MHz, TSC_delta should multiply APERF_delta instead
> >> of dividing it.
> >>
> >> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> >> ---
> >>   tools/power/x86/turbostat/turbostat.8 | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/t=
urbostat/turbostat.8
> >> index 8f08c3fd498d..1ba6340d3b3d 100644
> >> --- a/tools/power/x86/turbostat/turbostat.8
> >> +++ b/tools/power/x86/turbostat/turbostat.8
> >> @@ -370,7 +370,7 @@ below the processor's base frequency.
> >>
> >>   Busy% =3D MPERF_delta/TSC_delta
> >>
> >> -Bzy_MHz =3D TSC_delta/APERF_delta/MPERF_delta/measurement_interval
> >> +Bzy_MHz =3D TSC_delta*APERF_delta/MPERF_delta/measurement_interval
> >>
> >>   Note that these calculations depend on TSC_delta, so they
> >>   are not reliable during intervals when TSC_MHz is not running at the=
 base frequency.
>


--=20
Len Brown, Intel

