Return-Path: <linux-pm+bounces-34002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9D3B4601C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413EA1C804FC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7724EA9D;
	Fri,  5 Sep 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZvuxzun"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649EF3191D9;
	Fri,  5 Sep 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093265; cv=none; b=M4PNYddDA6EuwDHqeG6nVwwXjOQRaM/BuAAZt+ZgF5eLi4T1KA1UfXx9/oZSlIFGewIiK085YDHiNsZU6aXrzS2za25cY/Oobc0PyQ/q3MkAdIXHNdzYDELrgY+KvXo/toa1GZ/P1WopMveWCs/mi4OzVPuM3jZWF+Jis3IGEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093265; c=relaxed/simple;
	bh=/fjx5BWzjOdmNQHQSQLpxQ22WXogYjaHAXKWiill7h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4z3wMB8YZPbtaRgKi9O9QZdwMNLUI18z4vnu3BjwJZuqoUfMQ8gQqPgVVwCuyc6bZni0LO5P5ncDvenvCafB/xKMyNlX2X86UKgE9BVP1j951CNh2rZ+YnmL5GmuVc947QtR9J9wvAUSTxgy6dkd7KPYJlt/MDapePZblpa4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZvuxzun; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b00a9989633so444268766b.0;
        Fri, 05 Sep 2025 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093262; x=1757698062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4ruzCFcUV7SEcdpypiT1vJGfSBx8CrilcyOYgtpgss=;
        b=HZvuxzuniM/iahWVAq45RyP/mJEguqgYtPVmkFcFTjIOAvH//UX5pgQ/6ZEAkNDbkZ
         zgsurJw0whfJdP4Rm2luJ1GiH/tHmPkcVBF7KJk4kaqyaRTQunGKtivIXocc+Mr2PwOb
         qWjIuYYKxqszAxfG3v9gwbnYdiglmGTkSpv3pxbvAMeFeEG8CWRhqW1rRdRtd2j3JppS
         1VJq5pMu0x+zi20FJOymRzY2da66pZz68nLNUd0SpMHfYSBQP+Omq9uJRQ5JnJMbNV+j
         0xYSGZYb/P77tp5jI+mS/1rji9pZp9DJi2B/uND1NUboIn9V6tQndEDbTFPAf/OWwf8D
         D+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093262; x=1757698062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4ruzCFcUV7SEcdpypiT1vJGfSBx8CrilcyOYgtpgss=;
        b=sfkXvQHuUDoiZPscr+VGC7GIHfBo+7QQjfzSR0VHIRXaS6aTqNsBHygXWIVqTTDAA3
         4caGnCHZ4R1qLWsD4jD7u+tG1BLyqRoReRnRDhdaA1aBFKuAMYP5oMfd8fLKDKmL94aq
         l3juetB6cve7D9Ez+URwIEkeVWwzycuyw3SlLSrP9tAWp+rNZklAWsul3MDk+FJKgsrU
         dZJiiBpQ+JqIoriPF3gudkMdiRWRR8UIOjsyRiYxcVFuIYkbaLIDPFYRYt2HdDa6dYQ+
         pj1IN2xmj8hjlK7UqYIU2tXr7cEN+tR4wDrGJSPcfi053rJwSAMSpzclW5SMRqbmyJPX
         PFmw==
X-Forwarded-Encrypted: i=1; AJvYcCUYcZN5yF6lGVTdgCJlC0czGji2gIoCSu/PYdq1VNsWH/eTsm2im7vsSLHDq8S19010HTnTTt0fuf6nkAA=@vger.kernel.org, AJvYcCUZYjTgZfeEv+bSOTh/X/c4s8TLrwM4LdgfBuLcpFFxhRhJNBsbJ4tdezgI4LCsBqdbzhZ9Dn8NtQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC5zR/6x2V/Cw9SNliADbPWF598MPdOWl0Vs5t+QO/JrXmVb8
	Hh6PyHocJ/xbCewdjPsgsJki9eTCrCwAetJF6UBmwMOZ1hwv0Pe1w/lZuPaeebv4a1siM07PpM8
	k3J/HlIjey0SdiPzyQ3/PqByCDNmlxqY=
X-Gm-Gg: ASbGnctJ5ml0NaDsVnPXutF664rZCF9+eAE0bpPGAKh31l0RYsA/QWraVyop6h4ALNz
	cFPB+qBgXFeOxKmceMk+svGrHwMQ1Qpy5aECPzzftTox+uOhMcCMTsosv4xUTNTO0G+FhNih7o/
	PS1pQtTECejNrtXf39CnABCPhQaq1vlvL8G5S7IwJAyemzCIdTD/2UZqmRBORvadzG8HwyNa//0
	3kaHmaVg3jE0dRFamivKKOFCDifw6mNk1rRHYrc2dB0eIO39pg=
X-Google-Smtp-Source: AGHT+IEAaLgKrXjgXt+6D5U8EOgOZ5wN2cKnK9fGfiKEt3Dg9kLwtbpEhTpRCbsqjyVkOY/k1ccq1hFsTplbWYYKB8k=
X-Received: by 2002:a17:907:7e8b:b0:afe:ef8a:a48b with SMTP id
 a640c23a62f3a-b04932a3098mr478941066b.30.1757093261353; Fri, 05 Sep 2025
 10:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825185807.57668-1-vivekyadav1207731111@gmail.com> <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gfrTvLgs=PdmRbRRN05GE4Bk8Q7hJdtQfyk3VqaOz7FQ@mail.gmail.com>
From: vivek yadav <vivekyadav1207731111@gmail.com>
Date: Fri, 5 Sep 2025 22:57:31 +0530
X-Gm-Features: Ac12FXws6O7TgkFBepo_DQXCMVKTsEEWm_xmr6hzfYb_tRSbRc9iwL6b4hQiAus
Message-ID: <CABPSWR5cG=xTA72BHayYQTb=24VS3N+=dbsiMcU+gyqTKvNXAQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.com> wr=
ote:
>>
>> From: Vivek Yadav <vivekyadav1207731111@gmail.com>
>>
>> The ->show() callbacks in sysfs should use sysfs_emit() or
>> sysfs_emit_at() when formatting values for user space. These helpers
>> are the recommended way to ensure correct buffer handling and
>> consistency across the kernel.
>>
>> See Documentation/filesystems/sysfs.rst for details.
>>
>> No functional change intended.
>>
>> Suggested-by: Joe Perches <joe@perches.com>
>> Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
>> ---
>>  drivers/cpuidle/sysfs.c | 38 +++++++++++++++++++-------------------
>>  1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
>> index d6f5da61cb7d..c7af09460b74 100644
>> --- a/drivers/cpuidle/sysfs.c
>> +++ b/drivers/cpuidle/sysfs.c
>> @@ -22,21 +22,21 @@ static ssize_t show_available_governors(struct devic=
e *dev,
>>                                         struct device_attribute *attr,
>>                                         char *buf)
>>  {
>> -       ssize_t i =3D 0;
>> +       ssize_t len =3D 0;
>
>The variable rename is not necessary or even useful AFAICS ->

There is no harm if we leave the variable name as 'i' but it would be bette=
r
if we give it a suitable name like 'offset'. It will definitely improve
readability.

>
>>         struct cpuidle_governor *tmp;
>>
>>         mutex_lock(&cpuidle_lock);
>>         list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
>> -               if (i >=3D (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)=
))
>> +               if (len >=3D (ssize_t)(PAGE_SIZE - (CPUIDLE_NAME_LEN + 2=
)))
>>                         goto out;
>>
>> -               i +=3D scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", t=
mp->name);
>> +               len +=3D sysfs_emit_at(buf, len, "%.*s ", CPUIDLE_NAME_L=
EN, tmp->name);
>
>-> because the second argument here is still an offset relative to
>buf, isn't it?

I think 'len' is also not a good name. Now I have two options.
Either I can remove this part from the patch or I can make new patch
where I can change the variable name 'i' into a more meaningful name
like 'offset'.

Let me know in which direction I should move.

~Vivek


On Fri, Sep 5, 2025 at 1:05=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Aug 25, 2025 at 8:58=E2=80=AFPM <vivekyadav1207731111@gmail.com> =
wrote:
> >
> > From: Vivek Yadav <vivekyadav1207731111@gmail.com>
> >
> > The ->show() callbacks in sysfs should use sysfs_emit() or
> > sysfs_emit_at() when formatting values for user space. These helpers
> > are the recommended way to ensure correct buffer handling and
> > consistency across the kernel.
> >
> > See Documentation/filesystems/sysfs.rst for details.
> >
> > No functional change intended.
> >
> > Suggested-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
> > ---
> >  drivers/cpuidle/sysfs.c | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > index d6f5da61cb7d..c7af09460b74 100644
> > --- a/drivers/cpuidle/sysfs.c
> > +++ b/drivers/cpuidle/sysfs.c
> > @@ -22,21 +22,21 @@ static ssize_t show_available_governors(struct devi=
ce *dev,
> >                                         struct device_attribute *attr,
> >                                         char *buf)
> >  {
> > -       ssize_t i =3D 0;
> > +       ssize_t len =3D 0;
>
> The variable rename is not necessary or even useful AFAICS ->
>
> >         struct cpuidle_governor *tmp;
> >
> >         mutex_lock(&cpuidle_lock);
> >         list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
> > -               if (i >=3D (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2=
)))
> > +               if (len >=3D (ssize_t)(PAGE_SIZE - (CPUIDLE_NAME_LEN + =
2)))
> >                         goto out;
> >
> > -               i +=3D scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", =
tmp->name);
> > +               len +=3D sysfs_emit_at(buf, len, "%.*s ", CPUIDLE_NAME_=
LEN, tmp->name);
>
> -> because the second argument here is still an offset relative to
> buf, isn't it?
>
> >         }
> >
> >  out:
> > -       i+=3D sprintf(&buf[i], "\n");
> > +       len +=3D sysfs_emit_at(buf, len, "\n");
> >         mutex_unlock(&cpuidle_lock);
> > -       return i;
> > +       return len;
> >  }
> >
> >  static ssize_t show_current_driver(struct device *dev,
> > @@ -49,9 +49,9 @@ static ssize_t show_current_driver(struct device *dev=
,
> >         spin_lock(&cpuidle_driver_lock);
> >         drv =3D cpuidle_get_driver();
> >         if (drv)
> > -               ret =3D sprintf(buf, "%s\n", drv->name);
> > +               ret =3D sysfs_emit(buf, "%s\n", drv->name);
> >         else
> > -               ret =3D sprintf(buf, "none\n");
> > +               ret =3D sysfs_emit(buf, "none\n");
> >         spin_unlock(&cpuidle_driver_lock);
> >
> >         return ret;
> > @@ -65,9 +65,9 @@ static ssize_t show_current_governor(struct device *d=
ev,
> >
> >         mutex_lock(&cpuidle_lock);
> >         if (cpuidle_curr_governor)
> > -               ret =3D sprintf(buf, "%s\n", cpuidle_curr_governor->nam=
e);
> > +               ret =3D sysfs_emit(buf, "%s\n", cpuidle_curr_governor->=
name);
> >         else
> > -               ret =3D sprintf(buf, "none\n");
> > +               ret =3D sysfs_emit(buf, "none\n");
> >         mutex_unlock(&cpuidle_lock);
> >
> >         return ret;
> > @@ -230,7 +230,7 @@ static struct cpuidle_state_attr attr_##_name =3D _=
_ATTR(_name, 0644, show, store)
> >  static ssize_t show_state_##_name(struct cpuidle_state *state, \
> >                          struct cpuidle_state_usage *state_usage, char =
*buf) \
> >  { \
> > -       return sprintf(buf, "%u\n", state->_name);\
> > +       return sysfs_emit(buf, "%u\n", state->_name);\
> >  }
> >
> >  #define define_show_state_ull_function(_name) \
> > @@ -238,7 +238,7 @@ static ssize_t show_state_##_name(struct cpuidle_st=
ate *state, \
> >                                   struct cpuidle_state_usage *state_usa=
ge, \
> >                                   char *buf)                           =
 \
> >  { \
> > -       return sprintf(buf, "%llu\n", state_usage->_name);\
> > +       return sysfs_emit(buf, "%llu\n", state_usage->_name);\
> >  }
> >
> >  #define define_show_state_str_function(_name) \
> > @@ -247,8 +247,8 @@ static ssize_t show_state_##_name(struct cpuidle_st=
ate *state, \
> >                                   char *buf)                           =
 \
> >  { \
> >         if (state->_name[0] =3D=3D '\0')\
> > -               return sprintf(buf, "<null>\n");\
> > -       return sprintf(buf, "%s\n", state->_name);\
> > +               return sysfs_emit(buf, "<null>\n");\
> > +       return sysfs_emit(buf, "%s\n", state->_name);\
> >  }
> >
> >  #define define_show_state_time_function(_name) \
> > @@ -256,7 +256,7 @@ static ssize_t show_state_##_name(struct cpuidle_st=
ate *state, \
> >                                   struct cpuidle_state_usage *state_usa=
ge, \
> >                                   char *buf) \
> >  { \
> > -       return sprintf(buf, "%llu\n", ktime_to_us(state->_name##_ns)); =
\
> > +       return sysfs_emit(buf, "%llu\n", ktime_to_us(state->_name##_ns)=
); \
> >  }
> >
> >  define_show_state_time_function(exit_latency)
> > @@ -273,14 +273,14 @@ static ssize_t show_state_time(struct cpuidle_sta=
te *state,
> >                                struct cpuidle_state_usage *state_usage,
> >                                char *buf)
> >  {
> > -       return sprintf(buf, "%llu\n", ktime_to_us(state_usage->time_ns)=
);
> > +       return sysfs_emit(buf, "%llu\n", ktime_to_us(state_usage->time_=
ns));
> >  }
> >
> >  static ssize_t show_state_disable(struct cpuidle_state *state,
> >                                   struct cpuidle_state_usage *state_usa=
ge,
> >                                   char *buf)
> >  {
> > -       return sprintf(buf, "%llu\n",
> > +       return sysfs_emit(buf, "%llu\n",
> >                        state_usage->disable & CPUIDLE_STATE_DISABLED_BY=
_USER);
> >  }
> >
> > @@ -310,7 +310,7 @@ static ssize_t show_state_default_status(struct cpu=
idle_state *state,
> >                                           struct cpuidle_state_usage *s=
tate_usage,
> >                                           char *buf)
> >  {
> > -       return sprintf(buf, "%s\n",
> > +       return sysfs_emit(buf, "%s\n",
> >                        state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "=
enabled");
> >  }
> >
> > @@ -358,7 +358,7 @@ static ssize_t show_state_s2idle_##_name(struct cpu=
idle_state *state, \
> >                                          struct cpuidle_state_usage *st=
ate_usage, \
> >                                          char *buf)                    =
         \
> >  { \
> > -       return sprintf(buf, "%llu\n", state_usage->s2idle_##_name);\
> > +       return sysfs_emit(buf, "%llu\n", state_usage->s2idle_##_name);\
> >  }
> >
> >  define_show_state_s2idle_ull_function(usage);
> > @@ -550,7 +550,7 @@ static ssize_t show_driver_name(struct cpuidle_driv=
er *drv, char *buf)
> >         ssize_t ret;
> >
> >         spin_lock(&cpuidle_driver_lock);
> > -       ret =3D sprintf(buf, "%s\n", drv ? drv->name : "none");
> > +       ret =3D sysfs_emit(buf, "%s\n", drv ? drv->name : "none");
> >         spin_unlock(&cpuidle_driver_lock);
> >
> >         return ret;
> > --

