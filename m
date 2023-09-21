Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F17A9A57
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 20:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIUSib (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 14:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjIUSiB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 14:38:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2CD9D0F
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 11:30:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-321530de76eso1194167f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695321043; x=1695925843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/lesyyYEsnt9FdfxR9CoxFmQAH4gicQBv/bIfqhS7o=;
        b=B3OiWa+IBhaNah5i0n0YBIg3vlcUuwp/vZ09TFMMATjPQnUeVbGGOPQAZ3ahDpiPj6
         qVMAhawdzPUVegYDRmkXIACfDBnrqMEvqXBqbE0yiZkDsmtlo0UqgASkWBvCHyAw9S1/
         BWUtcF+iI4qGaCsqYsEc8/03yzPjh10WTAJBkZ5az01tnuRbuq19d2WGPiTKf+KDGN6z
         VYQSIBbk7KUKJXkpV8ewYiB5g9IisTErUD2l3sMcDUferGKA/9/RtIdTdjsBMNKmNTBM
         htIF6Tb5mckFt/X+P3SAMMorx6yK40pwiTMoRul30+45k0v0IfxR6SMeWGk/nKDrJJBq
         oGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321043; x=1695925843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/lesyyYEsnt9FdfxR9CoxFmQAH4gicQBv/bIfqhS7o=;
        b=avzD8PegXs9anI+7lBwn6otX77R22xDvoM4bFKmLphX+9EoUEJXMUVxFvzcHE/a2CL
         LHd9GYGy6gpzuPhrawDJUvIAlI263abSwR2KjDLlj9DcUsV9hs25joUOLdZxpSNBJ8rN
         rjjeqiTFBdcGRmhoHXj3j++VKkAShBTwdSHW/wFTcxTQ88VFd07g5qOIGT4LSy0aHpyU
         F2AOhswU4kvp9+e/Z7l285W5VPUqCn5JrDwvEna4/5/lQjSbhE2Ze8dSFctzZFgtygST
         Bp8JsP+94a9Bgkn2MqZIVcP3DR62Wf0/lWSztZwAMwxymEymaQmD6UpyqLEMEzbqf80d
         YrPg==
X-Gm-Message-State: AOJu0Yw/c197QfmKA0EXpDTYtt94CcelzbYvohpwoq4UQ895SHiF5NxJ
        C/+AUG/FrOncySK94h/jvZ1ogVf2dqvTX+ebF26WKg==
X-Google-Smtp-Source: AGHT+IGJfbg273QOiGyWJV30e+vCp/gVKXDpLIBgIJKJV1ZLq7zoYeLh1EwUM6sczbGm0RhUCMN7/g==
X-Received: by 2002:a05:6402:64c:b0:523:100b:462b with SMTP id u12-20020a056402064c00b00523100b462bmr4294427edx.5.1695281801541;
        Thu, 21 Sep 2023 00:36:41 -0700 (PDT)
Received: from linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7d38d000000b0052fe12a864esm440591edq.57.2023.09.21.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:36:40 -0700 (PDT)
Date:   Thu, 21 Sep 2023 09:36:37 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 9/9] ACPI: thermal: Drop valid flag from struct
 acpi_thermal_trip
Message-ID: <20230921073637.GA3346@linaro.org>
References: <5708760.DvuYhMxLoT@kreacher>
 <9162925.CDJkKcVGEf@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9162925.CDJkKcVGEf@kreacher>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 12, 2023 at 08:47:23PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the valid flag in struct acpi_thermal_trip is in fact
> redundant, because the temperature field of invalid trips is always
> equal to THERMAL_TEMP_INVALID, so drop it from there and adjust the
> code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
