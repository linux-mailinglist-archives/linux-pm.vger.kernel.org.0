Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBE95771B3
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGPWDx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGPWDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 18:03:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECEA101D3
        for <linux-pm@vger.kernel.org>; Sat, 16 Jul 2022 15:03:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i186so60025wma.1
        for <linux-pm@vger.kernel.org>; Sat, 16 Jul 2022 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=in8dP2sVAJwL20WC+ey2xiIS8RvYJ+++v95kdgyyLfI=;
        b=wvFnKG1Rq/5tqH/UfPSMf7sF6je29q3mtyNBpqOCs65UViSige/B/6NWWkfC5LDp0U
         DxlDU8QRSjd7cE+wgV920F8k7+Gx6IcETkrGLiDJYRKm1xIBMRyl+21BK9MmNNQy20s2
         NzskpaR1MJE2afI2UhFVuGlYz61X2cDTtHW57vq9l9l1gjIZ6oHMjYIMtqSk1UQf3XpS
         hpfl1Cby593kRvUiOiKkzyGrqkAWpkSnqtnMRGSc5swIK5s36deTcuy20+8fS66hyqf/
         MD3q+RzxiBf/BB94shf0Uw9eRtUVaApXpcOWFMk8F/7ATWFEYaP1PkQejE9DBuV6a2KV
         kNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=in8dP2sVAJwL20WC+ey2xiIS8RvYJ+++v95kdgyyLfI=;
        b=V6GCgLooUsw9ROpQ1iLGiDF+DVIEecC/guI2LsbPnSFPqHeiO9PM+4RfyWvpx7Jipb
         xf4674slAG71SVIxG1dgQxDJklDMFS1INNVwuf4LtwDt1krY/oIlb9FinIBf+iE5IsqE
         vyULkEyLSpx8NBpv4b5NzgeyEKmY5hXT3gbhT/QyGb1Vkicd18nrYqK4g+U6NH7zAZUt
         EskxDiWbnpQgqaKS4J/OD8FyTT6AJb0FxRUxkHaCIW4fsl5ewzAdqfA4qJTX+1KIfnxx
         AysoEULBU4u8m+vpxo8KDRdvcywtz3++BzRj4ggvo6vCaujfVAz3RYtPczRwKB4daTCT
         UWxQ==
X-Gm-Message-State: AJIora9q67YD0hIYd568r9OWAP3s4I1Wr7xywMCmiqLgjcXu/jrh3Xqc
        wCCRtbjR33fgkkm/2YXn6vfhKijizkcYog==
X-Google-Smtp-Source: AGRyM1v56UPTnUR8bueb6gCkBWa2T1CjMhRJjF2ultE1kWnq7f0MASQ2OEaeG72VxByrdfGMeHozBg==
X-Received: by 2002:a1c:2b05:0:b0:3a0:2ae2:5277 with SMTP id r5-20020a1c2b05000000b003a02ae25277mr20805826wmr.30.1658009028148;
        Sat, 16 Jul 2022 15:03:48 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6a38:5652:1b0c:da5e? ([2a05:6e02:1041:c10:6a38:5652:1b0c:da5e])
        by smtp.googlemail.com with ESMTPSA id c6-20020a7bc006000000b003a02f957245sm13484447wmb.26.2022.07.16.15.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 15:03:47 -0700 (PDT)
Message-ID: <f9e72fdf-ec3e-d2bf-691e-70b51123566c@linaro.org>
Date:   Sun, 17 Jul 2022 00:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] thermal/core: Fix refcount bugs in
 __thermal_cooling_device_register()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>, Liang He <windhl@126.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220707062112.308239-1-windhl@126.com>
 <CAJZ5v0iOF3n98byY5C4zAjM=AbxDiUHF9vqEp78i6_jg8M5MqQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iOF3n98byY5C4zAjM=AbxDiUHF9vqEp78i6_jg8M5MqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/07/2022 19:14, Rafael J. Wysocki wrote:
> On Thu, Jul 7, 2022 at 8:21 AM Liang He <windhl@126.com> wrote:

[ ... ]

>> -       cdev->np = np;
>> +       cdev->np = of_node_get(np);
>>          cdev->ops = ops;
>>          cdev->updated = false;
>>          cdev->device.class = &thermal_class;
>> @@ -947,6 +947,7 @@ __thermal_cooling_device_register(struct device_node *np,
>>          return cdev;
>>
>>   out_kfree_type:
>> +       of_node_put(cdev->np);
>>          thermal_cooling_device_destroy_sysfs(cdev);
>>          kfree(cdev->type);
>>          put_device(&cdev->device);
>> @@ -1111,6 +1112,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>>
>>          mutex_unlock(&thermal_list_lock);
>>
>> +       of_node_put(cdev->np);
> 
> Could this be done right before the
> thermal_cooling_device_destroy_sysfs() below?  Then the sequence would
> be completely analogous to the error code path above.
> 
>>          ida_simple_remove(&thermal_cdev_ida, cdev->id);
>>          device_del(&cdev->device);
>>          thermal_cooling_device_destroy_sysfs(cdev);
>> --
> 
> Overall, this looks like a genuine fix to me.
> 
> Daniel, what do you think?

Yes, the of_node_put() is often missing when there is the for_each_xxx 
OF API. But here the cdev->np is only used to compare pointers so used 
as an identifier, not de-referenced just comparing the addresses.

It is used to bind a thermal zone with a cooling device:

thermal_of.c:                   if (tcbp->cooling_device == cdev->np) {
thermal_of.c:                   if (tcbp->cooling_device == cdev->np) {

That is probably why no refcount was taken on this device node.

Moreover, this will go away with the series reworking the thermal-of I 
sent last week



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
