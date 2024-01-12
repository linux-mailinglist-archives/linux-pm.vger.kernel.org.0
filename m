Return-Path: <linux-pm+bounces-2164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5CF82C222
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 15:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3978A1F25ECE
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC796E2D6;
	Fri, 12 Jan 2024 14:50:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF56EB40
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598bb69ee60so80373eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 06:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071033; x=1705675833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/2NLH8eqOhKGrxhWVr6dTvEQEHksCT8VVh4kMDEU3Q=;
        b=istkjpHFY6zf6MZar19AtWPt3xAhsjSlB1Ra2ObcITom99DiQhwwVAwQOTiWxNqHml
         u7OYkiJbRCWqSlOuJKl2ti46djDIB9JOyc6lLjgVjZcTyo4hwO3dD/WYHr7i+uXvEfOd
         17IGBTJC5A0PzPPhR+b3oGiW9m1iDGk7YZupCWtsRktptXwd2oljyPRnehqGMkrG4tUY
         TvZH2d2NJZh5qKQ9EafRVFgHDVU0zUG/DtLoVIdeHmskmJyFU1/SUyVTAeIQD0HaEwpI
         VAUH8s4U4a2NkTQ/j5rsqBRHOySwEiNV84KsOsgPu1GbIjM7cWXJlnZfr12cxvJfn4O8
         mniw==
X-Gm-Message-State: AOJu0Yy26OfcP6M0wKBiC52jWf15panovSjx4YQuZEbk2Kzq3VmWiYMd
	TDop4JXEUTmJMLDufsmj9T/OBP+iqTInTmlnfVY=
X-Google-Smtp-Source: AGHT+IGvyL5ENkJPVhI4JCY8b9ldAhSdL8mArco/HpXiyG4SW7o8uQiX7Q78cM7BUrLlm8KGI7iioIG8TYT2tns869c=
X-Received: by 2002:a4a:9d19:0:b0:598:94b1:1658 with SMTP id
 w25-20020a4a9d19000000b0059894b11658mr1885857ooj.1.1705071033245; Fri, 12 Jan
 2024 06:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddde68fc-8693-42bd-bcff-c9ddbd1215c2@moroto.mountain>
In-Reply-To: <ddde68fc-8693-42bd-bcff-c9ddbd1215c2@moroto.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jan 2024 15:50:20 +0100
Message-ID: <CAJZ5v0g2s-VzhmZ8Ph+KdOPr4Jz4oubzxTbPM3YZhn7x3UFAzg@mail.gmail.com>
Subject: Re: [bug report] thermal/debugfs: Add thermal cooling device debugfs information
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 9:13=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Daniel Lezcano,
>
> The patch 90f2fb4afe8b: "thermal/debugfs: Add thermal cooling device
> debugfs information" from Jan 9, 2024 (linux-next), leads to the
> following Smatch static checker warning:
>
> drivers/thermal/thermal_debugfs.c:517 thermal_debug_cdev_remove() warn: '=
thermal_dbg' was already freed. (line 515)
> drivers/thermal/thermal_debugfs.c:835 thermal_debug_tz_remove() warn: 'th=
ermal_dbg' was already freed. (line 833)
>
> drivers/thermal/thermal_debugfs.c
>     504 void thermal_debug_cdev_remove(struct thermal_cooling_device *cde=
v)
>     505 {
>     506         struct thermal_debugfs *thermal_dbg =3D cdev->debugfs;
>     507
>     508         if (!thermal_dbg)
>     509                 return;
>     510
>     511         mutex_lock(&thermal_dbg->lock);
>     512
>     513         thermal_debugfs_cdev_clear(&thermal_dbg->cdev_dbg);
>     514         cdev->debugfs =3D NULL;
>     515         thermal_debugfs_remove_id(thermal_dbg);
>                                           ^^^^^^^^^^^
> Freed here.
>
>     516
> --> 517         mutex_unlock(&thermal_dbg->lock);
>                              ^^^^^^^^^^^^^^^^^^
> Use after free.  Same issue in the tz remove() function.
>
>     518 }
>

Good catch, thanks!

Fixed up in the tree.

