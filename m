Return-Path: <linux-pm+bounces-518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C97FDE1D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA75282A87
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1619C46BA7;
	Wed, 29 Nov 2023 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D573B2;
	Wed, 29 Nov 2023 09:14:40 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b85d97a529so940777b6e.0;
        Wed, 29 Nov 2023 09:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278079; x=1701882879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BTxP1AwTzLXl5jDe0Z7kCtR7I/vrVTah70CPbLH4S0=;
        b=FAfXAdaC80+Q/W/LPYt8abxZi3DZ7wHCIrgb8ekJsIyBipBlFS+0F94bWGg2zEmybm
         LVUGyKJ/B6XfYL+2ZIvrinnaEHM2ivItn2bYGt179Yhu+Obg0myMlz1WzabNYERqKuqo
         xpR9aLdsjpOdNlrXOUDb9K8RauNFJttlDHGA22bGhaNetglJKMlxU0EuKFBW1aYGe7QG
         6hQ+B5e1aCx1YtriwbdKFztdKSdFin5YiZPX3a9SJQp7ACSwPOHmFlaxp1dHmPIUEmnw
         BD847Ozc3VMJnCftz15K6sc6wazscd4mSyi1FsEVv4u0XesEulYkjX8dhaV05iJP8FwG
         xVhQ==
X-Gm-Message-State: AOJu0YxKumvjeaZL/H3TEY3s+ghfB47PAkrtqpw0O6opCs9dPELVBylz
	5mKbrJTyHI1WNgPMF4UnVLNYWNFvKoApdHZxUwum78e1
X-Google-Smtp-Source: AGHT+IG152vCdgIxEMGykqygUQVsz6Hdg5TzKW/KF5ZSpdliYWHwOwYY75niGuSgTIWLtW7dp2Z3NQpnzZuITgaJjIw=
X-Received: by 2002:a05:6808:d1:b0:3ae:5e6a:5693 with SMTP id
 t17-20020a05680800d100b003ae5e6a5693mr19467747oic.0.1701278079477; Wed, 29
 Nov 2023 09:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12350772.O9o76ZdvQC@kreacher> <4869676.GXAFRqVoOG@kreacher> <ce9297d4-db9f-44c7-a590-2b9d4600be42@linaro.org>
In-Reply-To: <ce9297d4-db9f-44c7-a590-2b9d4600be42@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Nov 2023 18:14:28 +0100
Message-ID: <CAJZ5v0j34VB6mkKjscU0BpQ8wvgeutr_2U50OznsmxSdTVySDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: trip: Rework thermal_zone_set_trip() and
 its callers
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Nov 29, 2023 at 5:54=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 29/11/2023 14:38, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Both trip_point_temp_store() and trip_point_hyst_store() use
> > thermal_zone_set_trip() to update a given trip point, but none of them
> > actually needs to change more than one field in struct thermal_trip
> > representing it.  However, each of them effectively calls
> > __thermal_zone_get_trip() twice in a row for the same trip index value,
> > once directly and once via thermal_zone_set_trip(), which is not
> > particularly efficient, and the way in which thermal_zone_set_trip()
> > carries out the update is not particularly straightforward.
> >
> > Moreover, some checks done by them both need not go under the thermal
> > zone lock and code duplication between them can be reduced quite a bit
> > by moving the majority of logic into thermal_zone_set_trip().
> >
> > Rework all of the above functions to address the above.
>
> Please hold on before merging this change. I've some comment about it
> but I have to double check a couple of things before

That's fine, but why don't you make the comment before the double checks?

