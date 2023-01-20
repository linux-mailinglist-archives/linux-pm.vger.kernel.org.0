Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533E567551C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jan 2023 13:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjATM7f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Jan 2023 07:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjATM7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2023 07:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC997BD156
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674219528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U1wPbxsoC7ZfahH+JPcdUFXDZ/H2t3btICQPs5Ikb/I=;
        b=dY1xRAp3/sDhPZ7ykf5arwNiAAl+6/NYvGiB1OhPrAeGuMnvCJb4247/bHQ/s5R6rFCVt3
        /HMSb14i7LPGtG3ub2KPJDIJ1ta4QsfCUK9lSkiL/mZvsX5Rn4euoaA5QaH7fqgRNz1enp
        kI2bHC9O+E/3GbhPS/T8WNpmGeg/7qI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-fY8G7nbZOzCpQqGQiTIaqQ-1; Fri, 20 Jan 2023 07:58:46 -0500
X-MC-Unique: fY8G7nbZOzCpQqGQiTIaqQ-1
Received: by mail-pj1-f72.google.com with SMTP id g20-20020a17090adb1400b0022941a246aaso2567329pjv.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2023 04:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1wPbxsoC7ZfahH+JPcdUFXDZ/H2t3btICQPs5Ikb/I=;
        b=iUuMSDFg0YaPsue0c1QmT7XkmUZKOc9oyydrOoy+a+X71TozZf+/mzrFQ5UyUsUWsf
         /2Q2eubZ+f4kPZ/sGHuTfYCVqZat1L9uxDZkqBCj4alRY4MsO1CeN84CzFAvcdWekYoe
         dOug5xv7cJQqrRWKKW4xUBmeXvGPzUrxwy/+XkFh6mtOUpQ/VBBmNz6cpHilslb8IfAC
         ILoiNxrgs2iajPiAKSm2TJihl1srq/uNmylnT4wxV8voI6Ee4CmD41NOXacWvkV6fFgL
         peTrVttF8UWJxoiYY5Ckt1Yh9JneNstEyNh/VSyLNJZQx9QN+dN3HlODfsVxZa0HUSnQ
         0wUQ==
X-Gm-Message-State: AFqh2kojk7VqfHfZ/uiskQsrkdUhEZxlORGFu+Yq98SiIxlsGUMA+JHx
        V0PlUPI88BCPEMXhCLBI4JON3/twF01NvkPVfptz/y061JQg5ghgXkSWa5+tL/j2lA50JF0kiG6
        zWAqSwZWU+TKQzkY15FJ7yLO0ylZKvw1M4DI=
X-Received: by 2002:a17:90a:af03:b0:229:f31f:8645 with SMTP id v3-20020a17090aaf0300b00229f31f8645mr779589pjq.82.1674219525810;
        Fri, 20 Jan 2023 04:58:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvB1QOzCk3oZ0M9r0H3dYGpyv1a8t7Rdl0khirKY1a+Nn7JihdcYBOkFFTOgz5KX2o0lX2YIkY7bQIzkLKsBlI=
X-Received: by 2002:a17:90a:af03:b0:229:f31f:8645 with SMTP id
 v3-20020a17090aaf0300b00229f31f8645mr779587pjq.82.1674219525535; Fri, 20 Jan
 2023 04:58:45 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucMEZHtRcB_MSjvs-Sp289gp9x5LM35RiNqbMOC1iaixg@mail.gmail.com>
 <CAJZ5v0huPSUXUbQ8JuHqRp2aaoA3QV698WfeS7UCCKuYyktaoA@mail.gmail.com>
In-Reply-To: <CAJZ5v0huPSUXUbQ8JuHqRp2aaoA3QV698WfeS7UCCKuYyktaoA@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 20 Jan 2023 13:58:34 +0100
Message-ID: <CACT4ouddzz2djws+wtj6aNgfVtK9VtkaG5rJijQYMeD-queZTw@mail.gmail.com>
Subject: Re: How to test one device pm ops
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 20, 2023 at 1:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> There's nothing like that, because testing system-wide suspend/resume
> for one device alone is not particularly useful.
>
> The system-wide suspend/resume callbacks run in a special system state
> (frozen user space and some additional restrictions) and there are
> dependencies between devices/drivers that need to be tested too.
>
> That's why /sys/power/pm_test is there.

Makes sense. Thanks for the quick response


--=20
=C3=8D=C3=B1igo Huguet

