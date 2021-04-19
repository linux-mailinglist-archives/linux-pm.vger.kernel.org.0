Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51261363E13
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 10:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhDSI6e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 04:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhDSI6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 04:58:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13240C061760
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 01:58:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so7596135wma.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0AjUlD7YkGhfW9VBmb7Q/nclm3RW7D/xFQEjGn/buc=;
        b=asPZgo+sY/2a3egyF9LO99HHqBlxAGInb1uUB9mYZeFfXXcOLo2Z+1Z7uK5wI24yju
         aHUxP7XNikvdhohHPdqlx/BPPPZxY7mJYQ9tXTNN9NtFbMyp17fcCiPMX0S8EZsWYL+g
         7BBKx+weOPi6/iOoH0DuahUq1snxJhdqMqQxMeMGKV8wrxa1WdwPxObSsfy9hYwCiVBb
         eO6rglmSoWRfmDXXkvIvcO0yiA/CIdrblT2yl0JepFTpUb18V6LyXIZDgq0pkD8aoC7g
         7PGlY1CYGjD5G2owA8aDlhty5goW3iUSgw5I2rxVvlbBVFe/Y2z67qDlcdZzS6pg6Dc/
         J/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0AjUlD7YkGhfW9VBmb7Q/nclm3RW7D/xFQEjGn/buc=;
        b=OOAagZ7+WIKYJn1kpLikGID/pjULl/yQF+GM1CT4Rt7OT2E6sLe0sJuLdXgB2mSBjn
         +yZTCbT2a+t7oRb/YkgR0mRjZ2aCZt5lozKK1oNEsfjGpawyFLwSNOOGP89PSWUAu7PO
         5kFRnZOtBxGgRU6R0Ed9DzlggXzb5Feg0OBE1xnUMWjPLsa8KMxa6Xby+pHTarBP0maW
         2F9ksIpL8AR1topVPXxXy4GpioAFgmqbdZEUE+Ct5WJ+1Kki6KG4kOdg7xOGCgo5t9BJ
         PeaiF36cY+IMkUBf7Gfeu7Quh2HlGjg42QrQNbY7fhFIhGOrW8VRWxb3hPlSESGHhk83
         he1w==
X-Gm-Message-State: AOAM53195N+vEKo7TGZTV3wiDedKDOBuOThZgMDmyhNijpHQ0ofUS1Ux
        1fpiK/dR0rrb5yFitzMdob54Lg==
X-Google-Smtp-Source: ABdhPJxJvSCYeTOnL9g/LKcqkmeEjxTohFCaB3z3OMm4onjWr8aK+toRZz1tmejbwBUjouvM2tryfA==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr20353289wmm.110.1618822682638;
        Mon, 19 Apr 2021 01:58:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:796f:a096:3809:6fc5? ([2a01:e34:ed2f:f020:796f:a096:3809:6fc5])
        by smtp.googlemail.com with ESMTPSA id g13sm25049407wrr.9.2021.04.19.01.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 01:58:02 -0700 (PDT)
Subject: Re: [thermal: thermal/next] thermal/drivers/tsens: Convert msm8960 to
 reg_field
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     thermal-bot for Ansuel Smith <tip-bot2@linutronix.de>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>, kbuild-all@lists.01.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2>
 <202104160110.kPF71m4S-lkp@intel.com>
 <CA+_ehUzAhPhqn62ivcxF+giMUy430eija7_sOSoNmC=291wq-g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4187051b-4dcf-88e0-ac3d-fb47ff42e3ef@linaro.org>
Date:   Mon, 19 Apr 2021 10:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+_ehUzAhPhqn62ivcxF+giMUy430eija7_sOSoNmC=291wq-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/04/2021 20:52, Ansuel Smith wrote:
>>
>> Hi thermal-bot,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v5.12-rc7]
>> [cannot apply to thermal/next next-20210415]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/thermal-bot-for-Ansuel-Smith/thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7f75285ca572eaabc028cf78c6ab5473d0d160be
>> config: arm-randconfig-r015-20210415 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/0day-ci/linux/commit/efea0f0570b6b581bdb2fad978a35fd1a521385b
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review thermal-bot-for-Ansuel-Smith/thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
>>         git checkout efea0f0570b6b581bdb2fad978a35fd1a521385b
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/thermal/qcom/tsens-8960.c: In function 'init_8960':
>>>> drivers/thermal/qcom/tsens-8960.c:193:29: error: 'S0_STATUS_ADDR' undeclared (first use in this function); did you mean 'INT_STATUS_ADDR'?
>>      193 |    priv->sensor[i].status = S0_STATUS_ADDR + 40;
>>          |                             ^~~~~~~~~~~~~~
>>          |                             INT_STATUS_ADDR
>>    drivers/thermal/qcom/tsens-8960.c:193:29: note: each undeclared identifier is reported only once for each function it appears in
>>    drivers/thermal/qcom/tsens-8960.c: At top level:
>>>> drivers/thermal/qcom/tsens-8960.c:284:15: error: 'VER_0' undeclared here (not in a function); did you mean 'VER_0_1'?
>>      284 |  .ver_major = VER_0,
>>          |               ^~~~~
>>          |               VER_0_1
>>
>>
>> vim +193 drivers/thermal/qcom/tsens-8960.c

[ ... ]

> What happened here? This doesn't seem right.

Yes, it is. It means the series is not git bisect safe.

Please fix it.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
