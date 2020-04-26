Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317091B91F5
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 19:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZRGy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 13:06:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45962 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgDZRGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 13:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1587920811; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTqCfxZBmTk09D67QB/ptZSM/wzN2C9X9u64qCP4L04=;
        b=Ybd/6LupQKabv0CLwPuklV2cLPT+1BYCbip7YvN2vRxljCCsK8W+b/ryb0r4GWtbTQOzer
        T3v4Fjg9/9aEuO++arc6fxNvxB0TfeQkVvQkkbh32M8kiMLGwRaTGUXJniBvOccf3fCaOR
        0i5Eu2tdYj3KR/s7gkra/EzzdnEjnqU=
Date:   Sun, 26 Apr 2020 19:06:40 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] PM: introduce pm_ptr() macro
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, od@zcrc.me,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Message-Id: <4JNE9Q.Y5HBZ952XKLI@crapouillou.net>
In-Reply-To: <2708095.iQXV2FnTNx@kreacher>
References: <20200413123207.74552-1-paul@crapouillou.net>
        <2708095.iQXV2FnTNx@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Le dim. 26 avril 2020 =E0 17:40, Rafael J. Wysocki <rjw@rjwysocki.net> a=20
=E9crit :
> On Monday, April 13, 2020 2:32:05 PM CEST Paul Cercueil wrote:
>>  This macro is analogous to the infamous of_match_ptr(). If CONFIG_PM
>>  is enabled, this macro will resolve to its argument, otherwise to=20
>> NULL.
>=20
> Well, this is going to result in quite a bit of unused code being
> added to the kernels built with CONFIG_PM unset.
>=20
> Is there any way to avoid that somehow?

Using __maybe_unused on the dev_pm_ops struct and the callbacks, as=20
long as they are static, they should be dropped by the compiler when=20
CONFIG_PM is not set.

-Paul

>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>  Notes:
>>      v2: Remove pm_sleep_ptr() macro
>>=20
>>   include/linux/pm.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>=20
>>  diff --git a/include/linux/pm.h b/include/linux/pm.h
>>  index e057d1fa2469..1c0eec06905d 100644
>>  --- a/include/linux/pm.h
>>  +++ b/include/linux/pm.h
>>  @@ -374,6 +374,12 @@ const struct dev_pm_ops name =3D { \
>>   	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>>   }
>>=20
>>  +#ifdef CONFIG_PM
>>  +#define pm_ptr(_ptr) (_ptr)
>>  +#else
>>  +#define pm_ptr(_ptr) NULL
>>  +#endif
>>  +
>>   /*
>>    * PM_EVENT_ messages
>>    *
>>=20
>=20
>=20
>=20
>=20


