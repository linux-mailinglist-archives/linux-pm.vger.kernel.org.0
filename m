Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4975A264B59
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIJRdl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 13:33:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37697 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgIJRXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 13:23:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id a3so6674994oib.4;
        Thu, 10 Sep 2020 10:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YXEBZOH+T+RhFJFPDEUgKSmlEXTOglbsDJ60nDEBkg=;
        b=N6Ik9K18BJYB0UftQP3kUIqovwNFM2VOSHR+e4/43SoGZMC1kIUQK6zw5i107Byy3Q
         W7j//szKJhgCmRbEeKMQV/eJgeskk4EtSWyI6fMRbmKs866nR1+OBbVNpN+YVRnhnyKl
         92i6Jud2DeIG2dWflPOZnnd9+bViNN+bxbFwwfvaNTRu4Lrrhjl9SsH2x6ouqH0AhMUS
         QP9uSagnC3Zt0zITk/N6R23BbbmwHOr9GsgaVYlhBwOQSbpBbu5tiY4PXp4tYHGiQdtk
         dmSe2BYH2vIzlIz7CQ+/h76lwBFBjDEQs0kSmuWWINMAQgDniHurpd9LRQONOv0huRa6
         dO5Q==
X-Gm-Message-State: AOAM533eXV3OwrLCObrnK6ivP2wSMGqcWvCxB3ol9m72WTaoCOip8fMR
        HESAyAWFS5b8GOQ3gcfSKSCazXE6cMm1kgAeFgo=
X-Google-Smtp-Source: ABdhPJwUdXfy0DyKAuD41O86HmDXJql8iH0o6k9jHIrjzcHWv88oKjuYV+hGoGWBTz7Q1umF54ChchENEJMYigi+X8g=
X-Received: by 2002:aca:df84:: with SMTP id w126mr681428oig.103.1599758622685;
 Thu, 10 Sep 2020 10:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <e40a76dbc4d17d0bc80daf95e259fcd6cc6d48e2.1599733531.git.amitk@kernel.org>
In-Reply-To: <e40a76dbc4d17d0bc80daf95e259fcd6cc6d48e2.1599733531.git.amitk@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Sep 2020 19:23:31 +0200
Message-ID: <CAJZ5v0h=1Jwxz40Ojp-tWh4BDDdphZKCAh0jZy2wCSGdSdZ+tA@mail.gmail.com>
Subject: Re: [PATCH] powercap: make documentation reflect code
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 10, 2020 at 12:28 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Fix up documentation of the struct members to reflect reality. Also
> fixup a stray whitespace.
>
> Signed-off-by: Amit Kucheria <amitk@kernel.org>
> ---
>  include/linux/powercap.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/powercap.h b/include/linux/powercap.h
> index 4537f57f9e42f..3d557bbcd2c71 100644
> --- a/include/linux/powercap.h
> +++ b/include/linux/powercap.h
> @@ -44,19 +44,18 @@ struct powercap_control_type_ops {
>  };
>
>  /**
> - * struct powercap_control_type- Defines a powercap control_type
> - * @name:              name of control_type
> + * struct powercap_control_type - Defines a powercap control_type
>   * @dev:               device for this control_type
>   * @idr:               idr to have unique id for its child
> - * @root_node:         Root holding power zones for this control_type
> + * @nr_zones:          counter for number of zones of this type
>   * @ops:               Pointer to callback struct
> - * @node_lock:         mutex for control type
> + * @lock:              mutex for control type
>   * @allocated:         This is possible that client owns the memory
>   *                     used by this structure. In this case
>   *                     this flag is set to false by framework to
>   *                     prevent deallocation during release process.
>   *                     Otherwise this flag is set to true.
> - * @ctrl_inst:         link to the control_type list
> + * @node:              linked-list node
>   *
>   * Defines powercap control_type. This acts as a container for power
>   * zones, which use same method to control power. E.g. RAPL, RAPL-PCI etc.
> @@ -129,7 +128,7 @@ struct powercap_zone_ops {
>   *                     this flag is set to false by framework to
>   *                     prevent deallocation during release process.
>   *                     Otherwise this flag is set to true.
> - * @constraint_ptr:    List of constraints for this zone.
> + * @constraints:       List of constraints for this zone.
>   *
>   * This defines a power zone instance. The fields of this structure are
>   * private, and should not be used by client drivers.
> --

Applied with some changelog edits as 5.9-rc material, thanks!
