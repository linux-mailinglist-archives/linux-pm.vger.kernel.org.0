Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CD59CFCD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 06:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiHWEN3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 00:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiHWEN1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 00:13:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3402CA460
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 21:13:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l64so11247641pge.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=pyFgXnehYDsTr0/o6fia2pSmXrfJdxul/IYfBmG5A5Q=;
        b=DypL39F/VcDwkpzvpYwgl4wSAfrc5zPFn4FWTZM5SAuleefwbcxfiPLVUg5ErLfCQB
         c7Jmqe1mVi+DYcREkWp7zFjfbKCfpOrBQQ7QzuWHmQOsSSnExJ+x8TI3KSdhVzCHo//1
         zSzAB+LUlgqvHIDXl5WKUOW/77tzlMkoF9A2LIQA5CLgFuXqsJhoTuAksjY6Kz1E/zjh
         qiRmPtypR0vBOyKoaodb8eXzb4B8vGfFPc0dxFx2NSM0J+/YhAbfVMapcIzl5wd4hCgX
         6h5SG28QX1bTaiTUXGodrLjy6gOCD1xvdCQiXjDWHMy3T4+Y29/JLYND9TtD6ylfm23z
         hb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pyFgXnehYDsTr0/o6fia2pSmXrfJdxul/IYfBmG5A5Q=;
        b=HIpJNAHkshpivH93EDF3IcsSavFsFQEnp51Aswn1C6rg+E8Vf0ni0A5+nM0DvfFSzd
         O+bJLFIsqRrP+8igcT2r+z2Ur83Wd3IuuIppxMyZcL+sPhEnQ/fPFZK299pJBT6opszR
         gymYpXsr/Xddh+CGa4ZTUZnJCEk8HcSOObAIcYtWOc7KHhUm3k1aFFLqBsSSWMAn/zuA
         5wKO9WIGzR+7WeYPzK7IPLZahcqpyCQjMJj7hsMslmsV2dgvTLl6b6SENiKjMOHoESHt
         bZFEMxujEtd46ULYqiB00iQ1ZVKLyepfJdfdPuLW7GJGsE6Pt8+eg2w3CM/vzs3E0QOZ
         X13Q==
X-Gm-Message-State: ACgBeo04HYJ1cQoTHHxnATFDVP5khNEAb4dish6O/+p+OTV65cKhiXje
        +XivxhYA6rCB35nBxa+osmeI+Kg8oirOwg==
X-Google-Smtp-Source: AA6agR4I0e7IwrbbZ70I4eU38Wgs947jGZW6c7mthVYEAyZevYTMFWOzP5tEHOQqPHPrPDlajhKcqQ==
X-Received: by 2002:a65:6e0b:0:b0:429:c526:7d93 with SMTP id bd11-20020a656e0b000000b00429c5267d93mr18875943pgb.142.1661228005676;
        Mon, 22 Aug 2022 21:13:25 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b00170953de050sm9341552plg.50.2022.08.22.21.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 21:13:25 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:43:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chris Hyser <chris.hyser@oracle.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cppc_cpufreq: prevent crash on reading
 freqdomain_cpus
Message-ID: <20220823041320.w4ak3g5tdomyf3q5@vireshk-i7>
References: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
 <1660935837-7481-2-git-send-email-chris.hyser@oracle.com>
 <20220822053920.y6us5rsi6u5cdapi@vireshk-i7>
 <6a77acc7-2bc2-2f97-b3cb-32ad1dd21007@oracle.com>
 <7b716f03-fa86-dc49-6a8f-ac999503900e@oracle.com>
 <7eb7800b-6100-84b0-1855-3c5a330c810d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb7800b-6100-84b0-1855-3c5a330c810d@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-08-22, 16:14, Chris Hyser wrote:
> On yet further digging, that patch does appear to work. There is code that
> removes the current cpu on offline and as that is the only cpu, it does
> leave the policy->cpus empty. I think this patch must have showed up between
> when I first started digging into this problem and when I started trying to
> finalize my stuff. Thanks for pointing out the fix.

Great.

-- 
viresh
