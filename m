Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF3F7CA8C7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjJPNDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPNDQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 09:03:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB69B
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 06:03:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-325e9cd483eso4360004f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697461392; x=1698066192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRIQzJVjQPflm7dkpuP19WJe82g35LDlQb0GVzpSU1w=;
        b=rdq7w8UoEIBi4IvFhsjnIsE/U38Kzyh1fIQgfOAZpwJpbHqo9n+oOfr95r3S1gG5t4
         Z+0zov4oisqCe4cfZXGhMpA7hm03hhpVxfV2kWX5LCfBdOTRCELbMtdeDP59XBLsT+rJ
         9oKfnAZqyyWQD7Cb+S9gj3b+b2AGla2pIRSNDTwljk1jKc50yX9z0d2DnTo81HXY3KFZ
         qMiK5c6GULvVxIUouRISsiIEyQe//lV278dTtLb8ereWbMa0NoV0ES66q7Z4ZwVvjDfp
         6TnjWw75oIE6orBMnRUU3FAM7Fd7SISK1nG+IiZc0V5M4yYX0CNk9h4+NP6FUSFCayCT
         w2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461392; x=1698066192;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRIQzJVjQPflm7dkpuP19WJe82g35LDlQb0GVzpSU1w=;
        b=um5LxwNpNiwPH0aBQ7UypDzj0mEI1j/9mAD6JCAzRX8KFYcEruFht0lkOY+4CWnjEh
         tPxgLHZbaUe884IZb+Aq5OoxHDrTSozZTzc1urRxf6qcYqB7c9+cMPn9iS47mKCLFWzO
         9R9+6f9s8lcIRC4hOUudXHeakvX1Ci2i9qyOWL/9mDjRjgMl7rGF8sqEoFWsK202Zspr
         rkvxG4gmxpUOO0OkQ8TD5UEhJEBe11hVLlh5h2ffHfvngJhSJWPETQB5t028o060bAB0
         xYbixZu6eHJr3kqF/gKDtpkgflKVTS44ryRtpWwif9P/4pD5NcVv/KISKSCLoIqYta4f
         JINw==
X-Gm-Message-State: AOJu0YwGEJsypIevikmwOP+UsZpmwHsG6m0tTKopv0jne2gckh6KozFE
        4QlSBYaVc1StEU1cgJfEpBiMJQ==
X-Google-Smtp-Source: AGHT+IEPGnTU1wjlmS9k4eskeWOz3X5dd9Yu1/Dv87W8Q/I3q6SzPYkw++mhH/Yxniig/Pha2vh3mw==
X-Received: by 2002:a5d:4e88:0:b0:32d:9572:646e with SMTP id e8-20020a5d4e88000000b0032d9572646emr8283133wru.54.1697461391660;
        Mon, 16 Oct 2023 06:03:11 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id f18-20020adff452000000b0032dbf6bf7a2sm103447wrp.97.2023.10.16.06.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 06:03:11 -0700 (PDT)
Message-ID: <734738ec-b72f-49b4-9a4e-6aaf2a44c9f3@linaro.org>
Date:   Mon, 16 Oct 2023 15:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: PM QoS performance aggregator
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

the kernel provides an API to specify latency timings for devices and 
CPUs. In addition, it allows to deal with the frequencies.

However, the unit is Hz and that may not fit very well with some devices 
where the performance is an index. The devices can have different 
performance capping mechanisms under the hood (IOW the firmware).

The pm QoS seems to not have an interface to describe constraints based 
on performance index.

In the same page, the devices can also be requesting power values 
instead of performance indexes or frequencies. So having a power based 
pm QoS would make also sense IMO.

Actually, performance indexes, power values, frequencies are just all 
values but in different units.

Would it make sense to create a generic PM QoS constraint with values 
and units ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
