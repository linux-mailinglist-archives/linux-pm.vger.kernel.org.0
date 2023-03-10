Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5176B3A77
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCJJbY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 04:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCJJbC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 04:31:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C63CE03
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 01:28:23 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y10so3216433pfi.8
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 01:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678440501;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psT1U0rm4RuxzwL1psv8gdVVo+BGxhb10b8OD+anohk=;
        b=ACeASh/2SbEF8rs7tz7isj/bO6XbxwpPPaN9lY8qTJgRR5vW7m4hX894+fVPARY7Z3
         hk8dyjMpPzU08ygcGzIXjgcari2QS026mV6P0Uvzf0Wle/tQtEYd1jW/jdPSAqejkU92
         dW+hT6FssQGPlklDrpUThUMOY/HgItQ4gBYPQODDl8IK35JyeouBxuZYUWwyc9YpTCK7
         /cwBe84R7tacRIoxKtxkXbYF/F3RZtTbLZRomeVIRjxg2OAsNfFL9tyMeRlpQ9CzhHTB
         jSKJlxjW0r3nbzb03v1UZlWqiOM07OssZCL0ifWNnED+EE6ETHKaYgPZ5cAqI6xaBKWD
         lzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440501;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=psT1U0rm4RuxzwL1psv8gdVVo+BGxhb10b8OD+anohk=;
        b=P2EhMQouC+GjQlN1KSiVQkvZswSTIG5hrD24iGbcxA8CvLhKI1aLMnoeKR09j55W7h
         aO50fkMPs3lMzzEOJZiVaXXZ2AiUYYkbXCBC+pf3LeRQ2qabdoMKqtZ0aJMthQZ5QtkB
         4Plld30yt2yLGZujUbBGdvC2vjZb8SjgLWoBizIXe8mf6u/vDT4px+rEN6weoLGjJCrc
         kFRVWkNxNPdze8iOpj1ckOEJVzkL9W4+y2giTkQpK6fN5Z5ww4NzDgJIJD/qHuCYEIZX
         isGEPG6KU02uMlOlGXns5jxLT6bFUjuTE5CkqfzGYCH5PtSf1JPy3fZ8mRX9Tm34xMLE
         Vn0A==
X-Gm-Message-State: AO0yUKWUkuczHjaH8MLLhrmD7YByRQxn1gdoIuqmJxUF2xdrx1fvDjXy
        QKuB09oYpv/ft3Cq3z5Vujz1X7uJqPZIdw==
X-Google-Smtp-Source: AK7set8hiLjz5ARPfNWpVl9wOqQVVuLifxJJUcXVmRskZrzIfwpU7sRS0dH98gF7ud7YcxttqR1J2A==
X-Received: by 2002:aa7:9e44:0:b0:5d9:27a5:60bf with SMTP id z4-20020aa79e44000000b005d927a560bfmr20861011pfq.28.1678440501358;
        Fri, 10 Mar 2023 01:28:21 -0800 (PST)
Received: from ?IPV6:2405:201:1010:106f:653e:bbbc:9b01:9e48? ([2405:201:1010:106f:653e:bbbc:9b01:9e48])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b005e06234e70esm964688pfn.59.2023.03.10.01.28.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:28:21 -0800 (PST)
Message-ID: <ff760a8a-ef47-35db-dbd3-29821d640517@gmail.com>
Date:   Fri, 10 Mar 2023 14:57:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     linux-pm@vger.kernel.org
From:   Rahul Pathak <rpathakmailbox@gmail.com>
Subject: cpufreq: query regarding policy->min/max &
 policy->cpuinfo.min_freq/max_freq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

Sorry for the long email.

I have a query on the use case where the platform driver during
initialization can choose to configure policy->min/max with
a range which is a subset of policy->cpuinfo.min_freq/max_freq.
I am trying to understand if choosing a subset of range should
be preserved until any governor or explicit change from userspace
changes the
range.

Let me take an example -
From cppc_cpufreq.c which does this exactly -

/*
* Set min to lowest nonlinear perf to avoid any efficiency penalty (see
* Section 8.4.7.1.1.5 of ACPI 6.1 spec)
*/
policy->min = cppc_cpufreq_perf_to_khz(cpu_data,
       caps->lowest_nonlinear_perf);
policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
       caps->nominal_perf);
/*
* Set cpuinfo.min_freq to Lowest to make the full range of performance
* available if userspace wants to use any perf between lowest & lowest
* nonlinear perf
*/
policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data,
    caps->lowest_perf);
policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data,
    caps->nominal_perf);

During initialization when cpufreq core calls the cpufreq_init_policy()
and later cpufreq_set_policy(), inside that the new_data.min/max are not
there as valid values since there is no user input during initialization.

new_data.min = freq_qos_read_value(&policy->constraints, FREQ_QOS_MIN);
new_data.max = freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX);

So, only taking the case of new_data.min which is set to 0 at this time.

When subsequent cpufreq_driver->verify() compares the new_data.min with
cpuinfo->min_freq inside cpufreq_verify_within_cpu_limits() it extends
the policy->min to policy->cpuinfo.min_freq. Which ultimately becomes
the new effective minimum possible.

This means that setting the initial policy->min/max different from full
range policy->cpuinfo.min_freq/max_freq has no effect and it will always
be extended in the initialization only. And the driver should always set
policy->min/max same as policy->cpuinfo.min_freq/max_freq. Is this the
right understanding?

Thanks
Rahul
