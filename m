Return-Path: <linux-pm+bounces-1144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D472E812CC4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 11:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FB11C21495
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0AA3B789;
	Thu, 14 Dec 2023 10:19:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FE210C
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 02:19:18 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5908b15f43eso721045eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 02:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702549157; x=1703153957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoXse5YBaFwQxkCnJIWRSI/ahMpccvmtkfbYOx8YuKM=;
        b=WAfMHL3NrgaTnPODQ+kzTEFcquRBBSgYzchf1BWr/eQ5LoCkxW/M0NrWKBymYmdvfI
         0LuIHG0U6ygfZaWzpOdEem7CJQjHnMjb1zDNil6Dt81xE5AEDswSoXjav0rX9s99/OFt
         fvAAMNop2riY+wrnAM/lnCbdycBYF+XwKZRHnhBvf22pKDwlCLQTc0QlX/QsaIktljDy
         eYs+s2Yq6GcJe5oABMvn64nPww2HwI9fjGAmAmPqFxEbbdXAwzkUeidUs5AaNBmRqo/W
         xhR9T3TLmUfTsFXcY7tLUOEGK194n3It3gTHBUXVxyzLGGIUENfw5c0VSyg2QqA2AxvN
         UWQg==
X-Gm-Message-State: AOJu0YxSePajF0ltG2zjqgD9oY2B7wvGPAME7xVQ3pidZLF3P6/y72R5
	swfCHuUJ+pMXtP0LTweIjfnAm/grg2cVhEZH1I0=
X-Google-Smtp-Source: AGHT+IHlBxJm3KtCgnTA4kA7Est1vT6+BY/SBQrc2vDFbbYUx+tWKqAIKeC+dXjeMxhKYJM4O4Fg9B6Zgx35izRBpiE=
X-Received: by 2002:a05:6870:b028:b0:1fb:e5f:c530 with SMTP id
 y40-20020a056870b02800b001fb0e5fc530mr17532127oae.4.1702549156727; Thu, 14
 Dec 2023 02:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8e0ffcf-a09a-4f60-8d93-95e3fa086f3f@moroto.mountain>
In-Reply-To: <b8e0ffcf-a09a-4f60-8d93-95e3fa086f3f@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 11:19:05 +0100
Message-ID: <CAJZ5v0jomya=Qe3AjJinOgFvLzJB2u+98dN4FM2hTU8q85qSvg@mail.gmail.com>
Subject: Re: [bug report] thermal: core: Make thermal_zone_device_unregister()
 return after freeing the zone
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 11:05=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hello Rafael J. Wysocki,
>
> The patch 4649620d9404: "thermal: core: Make
> thermal_zone_device_unregister() return after freeing the zone" from
> Dec 8, 2023 (linux-next), leads to the following Smatch static
> checker warning:
>
>         drivers/thermal/thermal_core.c:1500 thermal_zone_device_unregiste=
r()
>         warn: freeing device managed memory (UAF): 'tz'
>
> drivers/thermal/thermal_core.c
>     1490
>     1491         device_del(&tz->device);
>     1492
>     1493         kfree(tz->tzp);
>     1494
>     1495         put_device(&tz->device);
>                  ^^^^^^^^^^^^^^^^^^^^^^^
> This check is based on the rule of thumb that probably this put_device()
> frees tz.

It doesn't do that.

> I tried to read the code to see if that was true, but ended
> up with even more questions.
>
>     1496
>     1497         thermal_notify_tz_delete(tz_id);
>     1498
>     1499         wait_for_completion(&tz->removal);
>                                      ^^^^^^^^^^^^
> Use after free?

Nope.

> --> 1500         kfree(tz);
>     1501 }
>
> tz is allocated in thermal_zone_device_register_with_trips().  Here is
> what the clean up looks like in that function:
>
> drivers/thermal/thermal_core.c
>   1389          /* Update the new thermal zone and mark it as already upd=
ated. */
>   1390          if (atomic_cmpxchg(&tz->need_update, 1, 0))
>   1391                  thermal_zone_device_update(tz, THERMAL_EVENT_UNSP=
ECIFIED);
>   1392
>   1393          thermal_notify_tz_create(tz->id, tz->type);
>   1394
>   1395          return tz;
>   1396
>   1397  unregister:
>   1398          device_del(&tz->device);
>   1399  release_device:
>   1400          put_device(&tz->device);
>   1401          tz =3D NULL;
>
> I couldn't find the release() function.

See the commit in question.  It's thermal_release().

>  But this code assumes that the put_device() does free tz.

No, it doesn't do that.  It completes the removal completion instead.

>   1402  remove_id:
>   1403          ida_free(&thermal_tz_ida, id);
>   1404  free_tzp:
>   1405          kfree(tz->tzp);
>                       ^^^^^^^
> This should have a NULL check.

Not really.

>         if (tz)
>                 kfree(tz->tzp);
>
>   1406  free_tz:
>   1407          kfree(tz);
>   1408          return ERR_PTR(result);
>   1409  }
>

But there is a bug in thermal_zone_device_register_with_trips() which
does tz =3D NULL before dereferencing tz in kfree(tz->tzp) below.

Thanks!

