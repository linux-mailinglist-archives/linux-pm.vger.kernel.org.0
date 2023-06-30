Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E2E7432D6
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jun 2023 04:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjF3CqC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jun 2023 22:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjF3CqA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 22:46:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A1C30EF
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 19:45:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-263253063f9so984552a91.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 19:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688093158; x=1690685158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hzvSD9GFhy/jKWa6fSxQTV3jRMi0i1mWv1yFuJ1OnQ=;
        b=YSpovZITc5f/rxtk6imAJ3XXDu0nxGqwQrM9vx9Pd7yO9XsCXifUh5a4AqpcOY0Um2
         WgFjsoGqV+U3JIaFz/bYoWyZXb5Qa9iwb43baFMNu5bkSeUAJcg94uSn14aCncybFATs
         OyVJR3SiB2JXrP8E1v7mg6yCV0rb3yJ6v2/Vvc1+zR2KqbDj/CyKF/FbdHHklKzRIdPy
         +3b7aAu169odsbTcGNjf128+voyIc3cJB1HaNu6irgey9lpxxSJAcgKLDTqq7cDmqWn/
         GQ+ev5H8/56w9z16YcUNiFue2+w2CSAZ/VWaOl4qtinnfr6WXeLlfV6tS9QG26/HkcI9
         FTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688093158; x=1690685158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hzvSD9GFhy/jKWa6fSxQTV3jRMi0i1mWv1yFuJ1OnQ=;
        b=jAhIwdbKQoUmEeRUVdNIiSU7Hxqmkox6bdMK9k1ZWyN3QPQaRbTm2BBYdCDuA/6Exd
         PPyZW8FFo5slonm4bNb1tJLdTKyxheVzI1J2BvL44kYAR01OvgGFrI0v+kMHDW9jy3Tb
         RqJPrylYPYokNHyDaW8uAT9zSuJnwKUIsg5D2dY0wIKaWVC0fD6b2zo4dhFhObCSOFw0
         /eGlzai4vyaoKG3/QFz1++0M9zljRfIB+s5B6KSGsFIlzb7Z7xls5IEeMtQTrlKx0Vej
         Abh/+1IpmuErq0v7B9q3hRGD895lxa1ZbbLY9BNMIsdTrzGjeA3qD9tqFTeJyd+y/FGv
         7W6A==
X-Gm-Message-State: ABy/qLYEUwl/ZVAZRMsTwtb2GIfaoJArsRzvcZKRXm6XvViRjBtH7HNH
        x/0YlnM3TiRBL3WaeXt4uA75pg==
X-Google-Smtp-Source: APBJJlEWt5SI1+Qi4PG5ZpyUp5NrkQNoe2RGNNki+4+TiyciwzaA770deJ1sLnP/XWUjWDOPC7mWpQ==
X-Received: by 2002:a17:90a:b81:b0:262:c291:4b6c with SMTP id 1-20020a17090a0b8100b00262c2914b6cmr1129635pjr.45.1688093158565;
        Thu, 29 Jun 2023 19:45:58 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090a4c8200b002609cadc56esm10549454pjh.11.2023.06.29.19.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:45:58 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     tglx@linutronix.de
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lizefan.x@bytedance.com,
        lizhe.67@bytedance.com, mingo@redhat.com, rafael@kernel.org,
        tony.luck@intel.com, viresh.kumar@linaro.org, x86@kernel.org,
        yuanzhu@bytedance.com
Subject: Re: [RFC] msr: judge the return val of function rdmsrl_on_cpu() by WARN_ON
Date:   Fri, 30 Jun 2023 10:45:49 +0800
Message-Id: <20230630024549.76487-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <87r0ptzxad.ffs@tglx>
References: <87r0ptzxad.ffs@tglx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 30 Jun 2023 at 01:03:22 +0200, tglx@linutronix.de wrote:
>Li!
>
>On Thu, Jun 29 2023 at 15:27, lizhe.67@bytedance.com wrote:
>
>> There are ten places call rdmsrl_on_cpu() in the current code without
>> judging the return value. This may introduce a potential bug. For example,
>> inj_bank_set() may return -EINVAL, show_base_frequency() may show an error
>> freq value, intel_pstate_hwp_set() may write an error value to the related
>> msr register and so on. But rdmsrl_on_cpu() do rarely returns an error, so
>> it seems that add a WARN_ON is enough for debugging.
>
>Can you please structure your changelogs as documented in:
>
>  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
>
>instead of providing a big lump of words?
>
>> There are ten places call rdmsrl_on_cpu() in the current code without
>> judging the return value.
>
>Return values are not judged. They are either ignored or checked/evaluated.
>
>> This may introduce a potential bug.
>
>Sure. Anything which does not check a return value from a function might
>be a bug, but you have to look at each instance whether its a bug or
>not.
>
>> For example, inj_bank_set() may return -EINVAL, show_base_frequency()
>> may show an error freq value, intel_pstate_hwp_set() may write an
>> error value to the related msr register and so on.  But
>> rdmsrl_on_cpu() do rarely returns an error, so it seems that add a
>> WARN_ON is enough for debugging.
>
>This is hillarious at best.
>
>  1) It does not matter at all whether that function returns an error rarely
>     or not.
>
>  2) Adding WARN_ON() without justification at each call site is not
>     enough. Neither for debugging nor for real world usage.
>
>You have to come up with individual patches for each callsite to add the
>WARN_ON() and in each patch you have to explain why it is justified and
>why there is no other solution, e.g. taking an error exit path.
>
>Just slapping WARN_ON()'s into the code without any deeper analysis is
>worse than the current state of the code.
>
>If you have identified a real world problem at any of these call sites
>then adding a WARN_ON() does not solve it at all.
>
>I'm looking forward to your profound anlysis of each of these "problems".
>
>Thanks,
>
>        tglx

Thanks for all your advice. I will analysis each of these "problems".
