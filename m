Return-Path: <linux-pm+bounces-22704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E20A4036E
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 00:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750A770216A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2F2080FC;
	Fri, 21 Feb 2025 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UlO13Dvg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE12063ED
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180497; cv=none; b=WoCRD/KEXuqxBC0f+wukGkmK0HjJVrtiNSbe+tiPJfhkAsTnJqhmv8/a5iHLNW4fZLMi7a4W/3HaAckqRe3+/ljouBeYag2R0NsX+DS7tAFdvXHTDurZaz5Re36be7QKnqRr45tLOdLvmj2X3k0MtVKlZCuChwoege0pO8nym/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180497; c=relaxed/simple;
	bh=Vl/c/T93mDlS+SAo6jWpGO0WCFcjOVagGDwU7OjE4CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0Z9u76MswAD702GfLWd1IFdCdhn9yrVW6FFTdLkWJcBkHwpKP7iDP+1LoSGC9KQjhdratG18qfyMHxs9+vmQXfSl1nE1T2aLT5JYB4puU0Qq4hHCVbwlVUdlxSiofkPwMSxK4F0oWNJpIciLdSWJkPBPIIQ/X0pGKIr5TGux7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UlO13Dvg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so420976166b.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 15:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180494; x=1740785294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dIS2An77/MyudXh45p4DCv6fIS8Vd5P9xJ/byU/bvk=;
        b=UlO13Dvgkdp3eWInrjVm45R9SKAeiI0d1P7QPWVYnV34LtO8ofBc6zbr/4HxKTtwdS
         yImm+SQHJJHeAlRNiRB62xcCd6urwiKuEILqCXO3tOcgHYYggCfkH49FD44lWEigg6l/
         pPM+KlzQIIPR51VeNiJB9n/7nJVMa5RhtzqGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180494; x=1740785294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dIS2An77/MyudXh45p4DCv6fIS8Vd5P9xJ/byU/bvk=;
        b=GVGo7y1TNWD3t38VZje4oFJLjy+2+7W8vFmBRsj8P1KKk42MZ5ktyPRKG2181R8Qqw
         7QjHk6MtyuAJPg4RfA0gGNo2sSmUyI1TJIShNNDUGeXwWCWCKptP059z4nTDD8H97jJf
         Dr4F19ni+MpDSxtcVieqyRSxeIztaCL0iKevdC6p1P5Mhusv332UwlcU8yFvfS7o3kLH
         J8pc9SaA39g8y3QqgstDj3hI1/SmMy+iTSpgSv163dxSfsEvPBvNjNhcpEWBre833NMt
         xOb1Kx/ZXqzrRax/U0DTNrlqJ6CePSY5ubpYJZDJU7Tgz5gj+MnyGfSYNg36pQpVlQqP
         AZ7Q==
X-Gm-Message-State: AOJu0YxEf/13Gql+Ew+Q0p95X6nq0CcRthnmXC2O/Q5K7uGdQ3h54Dma
	uHpyeMFO2BAwHV7Xi1Y5B6KXARvQk+0rlfnmVVYIo3wVI0RZM/v/CAx+yxaAHYP+F5OufpeSail
	nYxtu
X-Gm-Gg: ASbGncvzbos6DOx90HlfWWkAN4c01mbdcohU44jyB8Q8QPU7KdSSmFA+OFR/jiNhdlH
	fpUTbbcsudEBl6zC/wSWqTyKvgEwGAkKlxVkKRH7+D8Fa4xKbj5LU+jOXG3yqhzfr1OttL/bCbo
	V0Ndt6zHoxnKUNXMq8mpVw3d57O0jTBb8CbH6EKMy9iFwkfB20kHScE4zHf524Pkaer0SDJMuXl
	/DFYx6zMcPRvsGxE9epFMsG3V57tO6AiTDksVN0dDQIrRGygWkqwPFSp228bB9Ur2gPPt5xaSNT
	ZIhSxOmdtMwqCZfcTIEkf7le7ffR6L+R9eL7Zzmvkl7q45K0GXaCxSTf7I8Hlg==
X-Google-Smtp-Source: AGHT+IFBgyjHSc8Oc0RLsoN0EgvgAaqL56IMRgR0dk6f9HdKcCm05+LIxXUmmgyaN/n8fXdoEgarDQ==
X-Received: by 2002:a17:907:96a0:b0:aba:5f44:8822 with SMTP id a640c23a62f3a-abc099b838amr553695566b.11.1740180493997;
        Fri, 21 Feb 2025 15:28:13 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba577d6d6sm963836066b.136.2025.02.21.15.28.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:28:13 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f70170005so1110232f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 15:28:13 -0800 (PST)
X-Received: by 2002:a5d:648b:0:b0:38f:3139:f57f with SMTP id
 ffacd0b85a97d-38f6e95c31emr5375784f8f.16.1740180492926; Fri, 21 Feb 2025
 15:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2788228.mvXUDI8C0e@rjwysocki.net>
In-Reply-To: <2788228.mvXUDI8C0e@rjwysocki.net>
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Feb 2025 07:27:36 +0800
X-Gmail-Original-Message-ID: <CAKchOA1gfsE+URhBZCwbNrMmX8Xw+a4LR4DHuv5o+-6-mUd30w@mail.gmail.com>
X-Gm-Features: AWEUYZnHjbzCzaPcqF2-DvwTXXuS2cUtPqOEKZFJBpzO6CzMWdN5MrAWgJ1Mimg
Message-ID: <CAKchOA1gfsE+URhBZCwbNrMmX8Xw+a4LR4DHuv5o+-6-mUd30w@mail.gmail.com>
Subject: Re: [PATCH v1] thermal/of: Fix cdev lookup in thermal_of_should_bind()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Yu-Che Cheng <giver@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Yu-Che Cheng <giver@chromium.org>
Tested-by: Yu-Che Cheng <giver@chromium.org>

On Sat, Feb 22, 2025 at 12:57=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since thermal_of_should_bind() terminates the loop after processing
> the first child found in cooling-maps, it will never match more than
> one cdev to a given trip point which is incorrect, as there may be
> cooling-maps associating one trip point with multiple cooling devices.
>
> Address this by letting the loop continue until either all
> children have been processed or a matching one has been found.
>
> To avoid adding conditionals or goto statements, put the loop in
> question into a separate function and make that function return
> right away after finding a matching cooling-maps entry.
>
> Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone cal=
lback")
> Link: https://lore.kernel.org/linux-pm/20250219-fix-thermal-of-v1-1-de36e=
7a590c4@chromium.org/
> Reported-by: Yu-Che Cheng <giver@chromium.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/thermal_of.c |   50 ++++++++++++++++++++++++------------=
-------
>  1 file changed, 29 insertions(+), 21 deletions(-)
>
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -274,6 +274,34 @@
>         return true;
>  }
>
> +static bool thermal_of_cm_lookup(struct device_node *cm_np,
> +                                const struct thermal_trip *trip,
> +                                struct thermal_cooling_device *cdev,
> +                                struct cooling_spec *c)
> +{
> +       for_each_child_of_node_scoped(cm_np, child) {
> +               struct device_node *tr_np;
> +               int count, i;
> +
> +               tr_np =3D of_parse_phandle(child, "trip", 0);
> +               if (tr_np !=3D trip->priv)
> +                       continue;
> +
> +               /* The trip has been found, look up the cdev. */
> +               count =3D of_count_phandle_with_args(child, "cooling-devi=
ce",
> +                                                  "#cooling-cells");
> +               if (count <=3D 0)
> +                       pr_err("Add a cooling_device property with at lea=
st one device\n");
> +
> +               for (i =3D 0; i < count; i++) {
> +                       if (thermal_of_get_cooling_spec(child, i, cdev, c=
))
> +                               return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static bool thermal_of_should_bind(struct thermal_zone_device *tz,
>                                    const struct thermal_trip *trip,
>                                    struct thermal_cooling_device *cdev,
> @@ -293,27 +321,7 @@
>                 goto out;
>
>         /* Look up the trip and the cdev in the cooling maps. */
> -       for_each_child_of_node_scoped(cm_np, child) {
> -               struct device_node *tr_np;
> -               int count, i;
> -
> -               tr_np =3D of_parse_phandle(child, "trip", 0);
> -               if (tr_np !=3D trip->priv)
> -                       continue;
> -
> -               /* The trip has been found, look up the cdev. */
> -               count =3D of_count_phandle_with_args(child, "cooling-devi=
ce", "#cooling-cells");
> -               if (count <=3D 0)
> -                       pr_err("Add a cooling_device property with at lea=
st one device\n");
> -
> -               for (i =3D 0; i < count; i++) {
> -                       result =3D thermal_of_get_cooling_spec(child, i, =
cdev, c);
> -                       if (result)
> -                               break;
> -               }
> -
> -               break;
> -       }
> +       result =3D thermal_of_cm_lookup(cm_np, trip, cdev, c);
>
>         of_node_put(cm_np);
>  out:
>
>
>

