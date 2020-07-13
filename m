Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2421D3DA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 12:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgGMKhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgGMKhP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 06:37:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA40C061755;
        Mon, 13 Jul 2020 03:37:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so16928443lji.9;
        Mon, 13 Jul 2020 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2wzk0nXU0h78C8JoXPc0o3B8umh3R1NSlPKrClAK2A=;
        b=TyhHhG8j/g6D1lSP/mCH5hOH6d9SmAX5lAOb/D5HgVekJMckmZRR8I+EfaS5IV0XKf
         oXo/1/gCZ3zeTexVUDX9oxOIMR/p63F+auwHIO1hoX/xDfITGS2hwkz7lmUcB+5Ai7vW
         T+Nc4ZCMqYd3yIRLU9kAx8LZZVUXOy/fgZJq6Kj4Hw7r3VQsPdcY4fqQ5j5Lx1WBlCAJ
         JvWIK0c34qhyPT3kAGXV6R2LlvqYsWH3CVMUN4tnHmve6g5+K9+axWbb5fA8cE24Onjk
         ht2Tp6Ujud9eydh3mFYNqi32syvnJQH5283rbP6UCdQcgO35oq7tq4QF3D/+aEFoQxuD
         qg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2wzk0nXU0h78C8JoXPc0o3B8umh3R1NSlPKrClAK2A=;
        b=dCLV1NC09E4bGDFWkrNbcVnCaELiK5vAQ+YbctI8rNl+lqm0L6AFItzvyeVzhdfe/e
         lrH65EZZ5XEBRg5wQxKlh8YWflKkWUeDOdYO1gtngxXx1lvzrm0lu0rRYbHU1EZ1Mt8G
         W5khGz8WCxFUh0c680AWFUel361eEsrzelA7NTInlcI8IMkwGMnRn+PNCOyMBph05Muz
         par+bCU7EP/EThK1UMwAWbaImunfkEboWLL8qsRopfo/bpqxdzRbL6DzLJt8bXdzUNA6
         SpvXG9MavF8vyp76Ds22Rh0va03yCaJbpU9Z4nDTCJcbaEXts04tN/7Gig4EBSlEAOnh
         SgAA==
X-Gm-Message-State: AOAM5307ZAbUxDMoWXD557PWsZyjz9WGjv2+PPcfg+UVySn9IHDDOkkz
        eY4DhAJPxLttWzjOKIINU3dzb81m
X-Google-Smtp-Source: ABdhPJw1mX+th01sqvBL0LiigLJOOcm7zQ4+2MSaYxvjj+Se4p5aTPeFDDQKmosYyI4JaFgfju0m4w==
X-Received: by 2002:a05:651c:21a:: with SMTP id y26mr32660693ljn.106.1594636633051;
        Mon, 13 Jul 2020 03:37:13 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id k20sm3978640ljc.111.2020.07.13.03.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 03:37:12 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] PM / devfreq: Add governor flags to clarify the
 features
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200713083113.5595-1-cw00.choi@samsung.com>
 <CGME20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73@epcas1p2.samsung.com>
 <20200713083113.5595-3-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <746837bc-6734-3e52-453f-2b59bbca0230@gmail.com>
Date:   Mon, 13 Jul 2020 13:37:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713083113.5595-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.07.2020 11:31, Chanwoo Choi пишет:
> DEVFREQ supports the default governors like performance, powersave and also
> allows the devfreq driver to add their own governor like tegra30-devfreq.c
> according to their requirement. In result, some sysfs attributes are
> useful or not useful. Prior to that the user can access all sysfs attributes
> regardless of availability.
> 
> So, clarify the access permission of sysfs attributes according to governor.
> When adding the devfreq governor, can specify the available attribute
> information by using DEVFREQ_GOV_ATTR_* constant variable. The user can
> read or write the sysfs attributes in accordance to the specified attributes.
> 
> /* Devfreq governor flags for attributes and features */
> [Definition for sysfs attributes]
> - DEVFREQ_GOV_ATTR_GOVERNOR
> - DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS
> - DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES
> - DEVFREQ_GOV_ATTR_CUR_FREQ
> - DEVFREQ_GOV_ATTR_TARGET_FREQ
> - DEVFREQ_GOV_ATTR_MIN_FREQ
> - DEVFREQ_GOV_ATTR_MAX_FREQ
> - DEVFREQ_GOV_ATTR_TRANS_STAT
> - DEVFREQ_GOV_ATTR_POLLING_INTERVAL
> - DEVFREQ_GOV_ATTR_TIMER
> 
> Also, the devfreq governor is able to have the specific flag as follows
> in order to implement the specific feature. For example, Devfreq allows
> user to change the governors on runtime via sysfs interface.
> But, if devfreq device uses 'passive' governor, don't allow user to change
> the governor. For this case, define the DEVFREQ_GOV_FLAT_IMMUTABLE
> and set it to flag of passive governor.
> 
> [Definition for governor flag]
> - DEVFREQ_GOV_FLAG_IMMUTABLE
> : If immutable flag is set, governor is never changeable to other governors.
> - DEVFREQ_GOV_FLAG_IRQ_DRIVEN
> : Devfreq core won't schedule polling work for this governor if value is set.
> 
> [Table of governor flag for devfreq governors]
> ------------------------------------------------------------------------------
>                       | simple    | perfor | power | user | passive | tegra30
> 		      | ondemand  | mance  | save  | space|         |
> ------------------------------------------------------------------------------
> governor              | O         | O      | O     | O    | O       | O
> available_governors   | O         | O      | O     | O    | O       | O
> available_frequencies | O         | O      | O     | O    | O       | O
> cur_freq              | O         | O      | O     | O    | O       | O
> target_freq           | O         | O      | O     | O    | O       | O
> min_freq              | O         | O      | O     | O    | O       | O
> max_freq              | O         | O      | O     | O    | O       | O
> trans_stat            | O         | O      | O     | O    | O       | O
>                       --------------------------------------------------------
> polling_interval      | O         | X      | X     | X    | X       | O
> timer                 | O         | X      | X     | X    | X       | X
> ------------------------------------------------------------------------------
> immutable             | X         | X      | X     | X    | O       | O
> interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
> ------------------------------------------------------------------------------
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---

Hello, Chanwoo! I tested this series on NVIDIA Tegra30 and everything
working fine!

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>


BTW, I'm curious what do you think about hiding the unsupported debugfs
attributes per-device instead of returning the -EACCES?
