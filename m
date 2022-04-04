Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE44F1A70
	for <lists+linux-pm@lfdr.de>; Mon,  4 Apr 2022 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378936AbiDDVS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379511AbiDDRTz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 13:19:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAB013F77
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 10:17:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so4730243wrb.7
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNtaKQ/W4kzlxVZJxxV5vPIWkgcFCTJx+RZDk2ENwjY=;
        b=TZTG+Vp4kCH9znGmLVIxLa4TCaXoBaTMn5zfghJruKdi0VUxnnRWqSeSdFrknFklEp
         CHjUtx+MaATarJeDVSsoCOANc6cuqtS7e3eb7PB7Hls2F6I5xH8kuEfv8janjrikHHnD
         oggCFme7Ji6SEIR/UaJGTCC3YNcCN0WUOG9TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNtaKQ/W4kzlxVZJxxV5vPIWkgcFCTJx+RZDk2ENwjY=;
        b=b5aWghOG2D+d1jja/OpGJtlkVmgBY0K1cilLG0ZMhLlweh7lrW9CPh4HzIJKemK9Ak
         6eIPX6A/jfqkVQPIAl8zIZ0iazDVl1H8VUWLYRiuX3WHoi4ub0WQ31vdl/8qu0PQ+7gV
         kludrvUORMrMfjBSSP959DG2CyErvprqiMKfGAkYCq2uomnT1Rkg6E1/FbVXvTMjOYjE
         lwhb0wn1p4YlL64ZzY/ifrB1jBf5HY4XCD/+OnPioST3cNAGkM1DLc6Ja8bDBEKuw7eL
         4MhvuvsVu4hKYMKVC9/E9ALzNcanjZ0GI9avMVd6rOcrCBUgmL4uQx6/g0fOgyRLR2IE
         16zg==
X-Gm-Message-State: AOAM532viOlR0o+L+w6iCeFFwdZObWHDjQ3tChoxidmseeh7QWir5CPG
        KEGNlplzEM0z6i5DzxJUmKpSy8xBbsfrOT8f
X-Google-Smtp-Source: ABdhPJxdJrmlXUKqL74JeB1HzZ0cdk0um+2davLItplVQxLZjJH5eQ4hPcUrX9RzKjd8DkvpL5xAcg==
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id y1-20020adfd081000000b001ef9378b7ccmr564031wrh.407.1649092676958;
        Mon, 04 Apr 2022 10:17:56 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:521a])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b00205cf199abcsm9755918wrs.46.2022.04.04.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:17:56 -0700 (PDT)
Date:   Mon, 4 Apr 2022 18:17:55 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: Thermal notifications without setting thermal governor to
 userspace?
Message-ID: <YksoQ62CObN1R/oG@chrisdown.name>
References: <YkR6/KnH/f9U+2qf@chrisdown.name>
 <faf9e24f-4419-cdbb-573f-4cf2d9e506e2@linaro.org>
 <YksL8a+cINo7K/xX@chrisdown.name>
 <8f1428c7-cf0e-b2cc-c898-09935a9017da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8f1428c7-cf0e-b2cc-c898-09935a9017da@linaro.org>
User-Agent: Mutt/2.2.2 (aa28abe8) (2022-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Daniel Lezcano writes:
>Well on regular desktop, the thermal is managed under the hood by the 
>firmware/hardware, few sensors are exported AFAICT. I don't think a 
>thermal daemon would have a benefit on these platforms.

Maybe we have different expectations? On my laptop, a Thinkpad T14s, things 
seem not too bad:

     % printf '%s\n' /sys/class/hwmon/hwmon*/temp*_input
     /sys/class/hwmon/hwmon1/temp1_input
     /sys/class/hwmon/hwmon2/temp1_input
     /sys/class/hwmon/hwmon2/temp2_input
     /sys/class/hwmon/hwmon2/temp3_input
     /sys/class/hwmon/hwmon4/temp1_input
     /sys/class/hwmon/hwmon4/temp2_input
     /sys/class/hwmon/hwmon4/temp3_input
     /sys/class/hwmon/hwmon4/temp4_input
     /sys/class/hwmon/hwmon4/temp5_input
     /sys/class/hwmon/hwmon4/temp6_input
     /sys/class/hwmon/hwmon4/temp7_input
     /sys/class/hwmon/hwmon4/temp8_input
     /sys/class/hwmon/hwmon6/temp1_input
     /sys/class/hwmon/hwmon8/temp1_input
     /sys/class/hwmon/hwmon8/temp2_input
     /sys/class/hwmon/hwmon8/temp3_input
     /sys/class/hwmon/hwmon8/temp4_input
     /sys/class/hwmon/hwmon8/temp5_input

There are working temperature sensors out of the box for the CPU, wifi card, 
ACPI thermal zone, and extended sensors from thinkpad_acpi.

In my case, I'd like to get notifications in userspace when certain 
temperatures are reached.

So if I understood correctly, there's no way to dynamically configure 
temperature thresholds and get breach events even as root, even with the new 
netlink solution?

Thanks again for your help!

Chris
