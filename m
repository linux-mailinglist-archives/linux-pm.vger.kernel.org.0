Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318E5D9D79
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 23:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394652AbfJPVYP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 17:24:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39358 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394411AbfJPVYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 17:24:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so24217549qki.6
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gWxE/KKsGAGRNuWMBZchdW//NFYZ4z1sPA0PZe82a9E=;
        b=OIkVZAPCR9MXbvkmja2BT1NScH1NPHVGU5efTmIcYrM7juiRIQ2kmmIDudPuCXHGRR
         yjRNIQfkUco4XzP678q+cjEL+NUHTOWbdMIac93fVtBo+Zf3Yw5PqL5/euaCO+j9fNTv
         qkMRwTijfTJZBegfInhXGrrVQjlqvOeFI82Bu0KzcpPz/h4kQgFuKeUt6DdhRWlSdx25
         XEqK0s/FkevPjtOoB/JkxYW4jiNvgODoavQkux5NKBI9ikgcsmk745PVkcrF9jPxo2uS
         FNcePlr0UwSD18fWxtJj7eHB2g3cOzAywb4sa4eEL644aAXZ3nM1FIz/oHOyyh3twGus
         2r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gWxE/KKsGAGRNuWMBZchdW//NFYZ4z1sPA0PZe82a9E=;
        b=tzDDHQN8Zi8TV9BBaFaOIgae4Xt5KIAgDlScRNehamODKh0NQQtYvpQ7Frcs+G86Ua
         YqMSvxQVKH2uzV4SMnBNVzmoeuMIGiMLZhzbVuFfg6Ui6Hm8XwMFtXNDD7e9vJ8/ZJ5U
         VmCkoYwVXEJaQWROAiBfKV9ca1fuVA171L3aJH8FZdxrzSJjIu/ReaE11MAdKiUudt2f
         hezdCg2/paPKHzrRBIB2VBh6U9l1DSoZ26We5iHfN4MK71S2SMpX33ZMWgBqavoLfQyj
         LlcZPAyM4B1JVEX6J89V3sx0JL+rIe3EgfTxfqH+TH/lMQ21FYU6Qj4VW+b2CcqYcLG+
         fBGQ==
X-Gm-Message-State: APjAAAU32992Rq2mpdM8eG8JGcoWjGKALD1W45MC0DV+pe5ly280K81D
        dxQx6chd951SR5+ybm2O1H/ywA==
X-Google-Smtp-Source: APXvYqxxqDJ4QFlgsHsq0AqWVd9h3tRZnA2Br3bLJHBCdWIn2l+OnSf0M1OjOpSLgO3YO5CBXbQlLw==
X-Received: by 2002:a37:5257:: with SMTP id g84mr43399596qkb.247.1571261052011;
        Wed, 16 Oct 2019 14:24:12 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id 22sm83356qkj.0.2019.10.16.14.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 14:24:11 -0700 (PDT)
Subject: Re: [PATCH 0/4] thermal: Introduce support for monitoring falling
 temperatures.
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DA78A7A.7030400@linaro.org>
Date:   Wed, 16 Oct 2019 17:24:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/18/2019 10:18 PM, Thara Gopinath wrote:
> Thermal framework today supports monitoring for rising temperatures and
> subsequently initiating cooling action in case of a trip point being 
> crossed. There are scenarios where a SoC needs some warming action to be
> activated if the temperature falls below a cetain allowable limit.
> Since warming action can be considered mirror opposite of cooling action,
> most of the thermal framework can be re-used to achieve this.
> 
> To enable thermal framework to monitor falling temperature, a new parameter
> is added to the thermal trip point binding in the device tree to indicate
> the direction(rising/falling) of temperature monitoring. Thermal DT
> driver is extended to capture this information from the device tree 
> entries and to reflect it in the thermal framework as a new enum
> variable in the thermal trip point structure.
> As an initial attempt, step-wise governor is extended to support
> bi-directional monitoring of temprature if a trip point is hit, depending
> on the newly introduced enum variable. Finally thermal sysfs entries are
> extended to indicate the trip point monitor direction.
> 
> Patch series introducing various resources that are used as warming devices
> on Qualcomm sdm845:
> https://lkml.org/lkml/2019/7/29/749 (already merged)
> 
> https://lkml.org/lkml/2019/9/10/727 (under review)

Gentle reminder for reviews!
> 
> 
> Thara Gopinath (4):
>   dt-bindings: thermal: Introduce monitor-falling binding to thermal
>     trip point description
>   thermal: Thermal core and sysfs changes needed to support
>     bi-directional monitoring of trip points.
>   thermal: of-thermal: Extend thermal dt driver to support
>     bi-directional monitoring of a thermal trip point.
>   thermal: step_wise: Extend thermal step-wise governor to monitor
>     falling temperature.
> 
>  .../devicetree/bindings/thermal/thermal.txt        |  8 +++
>  drivers/thermal/of-thermal.c                       | 22 ++++++++
>  drivers/thermal/step_wise.c                        | 59 +++++++++++++++------
>  drivers/thermal/thermal_sysfs.c                    | 60 ++++++++++++++++++++--
>  include/linux/thermal.h                            | 10 ++++
>  include/uapi/linux/thermal.h                       |  2 +-
>  6 files changed, 141 insertions(+), 20 deletions(-)
> 


-- 
Warm Regards
Thara
