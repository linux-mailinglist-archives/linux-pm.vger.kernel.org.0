Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A981A6C5480
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 20:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCVTFI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 22 Mar 2023 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVTFH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 15:05:07 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B601DB84
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 12:05:06 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id eh3so77095022edb.11
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 12:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMGRJMBRtis8z79mMyjgUpr9fMkYEfoFGsO27Co9WIM=;
        b=70/qLmQYT7bQBBcAN22CfX2BqK5MeZlvLGCf6XnELUY4YIi/RrIwpHCGJJ0A6ndSr9
         djpUw2yyhexDgPNMRpmEMjTyzktajnYKintzqz6sJAV5gkCVzj64w5F9uH2zfwx1oTZy
         WRO0ONZ7w04xjVVzRlLbePifwS8cFoom+O+FGzN5qu+cNtlZJRP50tdl4OOuahHnby3H
         9lfUaeDrwFVDPPEsfokl7hH0iDApG/5JFBk1Nr9M3cnPudjYGj0zXtqe1DL6p65x5Xzd
         2dnMJnbDCywpJ9ArSvZWx+EYNPpVeU/21H6UDw0mcglh8DpktGNhJ7rPXSOj9qyW4YEF
         eGIA==
X-Gm-Message-State: AAQBX9fCs9Aem/vOMz0MzzOhaqjgai7Ojb1dMMaLsGYn/EkUaeHjNxEC
        jHSER0uJ0/ESDJywM520PcjMJjxlf3hYFgxBgOM=
X-Google-Smtp-Source: AKy350YuFyjgBmVwQzGd97OZH7cTiZgC6/LXMRdS9ScJNgSSrx69CT14gXmOI4iL82ZUugn4zK+AUUb15UWu1anAwn0=
X-Received: by 2002:a50:ce07:0:b0:502:4f7:d287 with SMTP id
 y7-20020a50ce07000000b0050204f7d287mr58604edi.3.1679511905472; Wed, 22 Mar
 2023 12:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230314155010.3692869-1-idosch@nvidia.com> <CAJZ5v0gKR6xzZUgATEMCGnAgtq3dGo-QyM372yvWqJPMu3r=GQ@mail.gmail.com>
 <ZBC+gUXyTsHHIX8O@shredder>
In-Reply-To: <ZBC+gUXyTsHHIX8O@shredder>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 20:04:54 +0100
Message-ID: <CAJZ5v0hiPqpN1O4fXhoORwmi3fU_5Us5U6FKxAoVJkvGAvn6HA@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Restore behavior regarding invalid trip points
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        mlxsw@nvidia.com, vadimp@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 14, 2023 at 7:35 PM Ido Schimmel <idosch@nvidia.com> wrote:
>
> Hi Rafael,
>
> On Tue, Mar 14, 2023 at 07:03:07PM +0100, Rafael J. Wysocki wrote:
> > What if the temperature is negative?  I think that you'd still want to
> > disable the trip in that case, wouldn't you?
>
> Personally, no. This patch merely restores the behavior that was
> inadvertently removed by 7c3d5c20dc16. Specifically by this hunk:
>
> ```
> @@ -1252,9 +1319,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>                 goto release_device;
>
>         for (count = 0; count < num_trips; count++) {
> -               if (tz->ops->get_trip_type(tz, count, &trip_type) ||
> -                   tz->ops->get_trip_temp(tz, count, &trip_temp) ||
> -                   !trip_temp)
> +               struct thermal_trip trip;
> +
> +               result = thermal_zone_get_trip(tz, count, &trip);
> +               if (result)
>                         set_bit(count, &tz->trips_disabled);
>         }
> ```
>
> > Daniel, what's your take on this?
>
> Discussed this with Daniel yesterday:
> https://lore.kernel.org/linux-pm/ZA8TPDpEVanOpjEp@shredder/
>
> We agreed to rework mlxsw to not rely on the fact that trip points with
> a zero temperature are disabled, but it's not rc material, unlike this
> patch.

So I've applied this as 6.3-rc material for the sake of avoiding a
driver regression in 6.3, under the assumption that we'll get the
mlxsw driver update on time for the 6.4 merge window.

Thanks!
