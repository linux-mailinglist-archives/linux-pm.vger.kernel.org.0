Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B68361288
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhDOSxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 14:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhDOSxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 14:53:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF09C061574
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 11:52:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n8so40911247lfh.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Apr 2021 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3cA59d1qTM+mful+3HmYtDKVEXK1j6v5R548Ohs+ho=;
        b=InuWxulxIjMcMgvI2RDhfWxDvqp6S/2/tWuV1TvbaeCOteURsmFXM7t1hQmVl1ruSF
         fMG2Z+0WXfsR8QrA+E7qjD7Z3UC60pGd1W7mgxNUtwnQLLn73EW4bi9S+0/fysY/jwOb
         Jcsj8fl7WpYdZQL5gQnWDTNBPQ1JUh7IF26tkaro5VhluAsePiAlBmVq4Amxka+9CJEP
         viTlrsPKtmCZXCMifrCYo7dJUtwCeJdI07dmODQVt6fp+Fmd1MoeaPlPxwkh9617yKrJ
         VDohI6SClsvqjZQxWoqlojce5kxFEK9wbey26n8YrJ7NrQqgC6Zw0m5iZY69nOzyelGJ
         U/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3cA59d1qTM+mful+3HmYtDKVEXK1j6v5R548Ohs+ho=;
        b=IV7TgEqIvV9v91bvffQ1X7FChD/BNv1+LoCUzwhzwvTNhIrSgxyRv6EsyOZLbMdwk3
         h1NWDQAnkBzC7q5TCVERidTbxQdD8zomKtdx5Mk+WrgrKr4GMX6GOn37ZaPZPRc5J77u
         rVFbGDvJN36WDZJuxs9S3uUOFa2WfdBtVYGcI5JCnrLsH1mSislOwyxPYwekopugu++G
         Bm7WJNwx+wN0Mvq4kiWySghkr8y1OfvC0resSTm+u6ur1heTAnGzsBaQnbgRWi1XD4/X
         kcjboRujjiZDj53VsiGDV63lVEC9QXbWvAxdJ8YeShGoqcm7SsRc87oYhC4++czoZImI
         9AGQ==
X-Gm-Message-State: AOAM533h20rpWNmHY5qgB7N1espnKEaL8dSEg7nUv906nxH23UKr2gV5
        I+ZQoTDAyXE37VlBmysCYEG3PEnkp3IeMI+Y0ZeBdEt4ezs=
X-Google-Smtp-Source: ABdhPJyHJV6KSLwcVgKTqkq+D9OecbotmVHNRkDf2sgfCYrWP7c+Gk92CgK81xPmuG98t+9UinDTvSUCKPOfNcd6il4=
X-Received: by 2002:ac2:555a:: with SMTP id l26mr330839lfk.653.1618512754645;
 Thu, 15 Apr 2021 11:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2> <202104160110.kPF71m4S-lkp@intel.com>
In-Reply-To: <202104160110.kPF71m4S-lkp@intel.com>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Thu, 15 Apr 2021 20:52:20 +0200
Message-ID: <CA+_ehUzAhPhqn62ivcxF+giMUy430eija7_sOSoNmC=291wq-g@mail.gmail.com>
Subject: Re: [thermal: thermal/next] thermal/drivers/tsens: Convert msm8960 to reg_field
To:     kernel test robot <lkp@intel.com>
Cc:     thermal-bot for Ansuel Smith <tip-bot2@linutronix.de>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>, kbuild-all@lists.01.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>
> Hi thermal-bot,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.12-rc7]
> [cannot apply to thermal/next next-20210415]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/thermal-bot-for-Ansuel-Smith/thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7f75285ca572eaabc028cf78c6ab5473d0d160be
> config: arm-randconfig-r015-20210415 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/efea0f0570b6b581bdb2fad978a35fd1a521385b
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review thermal-bot-for-Ansuel-Smith/thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
>         git checkout efea0f0570b6b581bdb2fad978a35fd1a521385b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/thermal/qcom/tsens-8960.c: In function 'init_8960':
> >> drivers/thermal/qcom/tsens-8960.c:193:29: error: 'S0_STATUS_ADDR' undeclared (first use in this function); did you mean 'INT_STATUS_ADDR'?
>      193 |    priv->sensor[i].status = S0_STATUS_ADDR + 40;
>          |                             ^~~~~~~~~~~~~~
>          |                             INT_STATUS_ADDR
>    drivers/thermal/qcom/tsens-8960.c:193:29: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/thermal/qcom/tsens-8960.c: At top level:
> >> drivers/thermal/qcom/tsens-8960.c:284:15: error: 'VER_0' undeclared here (not in a function); did you mean 'VER_0_1'?
>      284 |  .ver_major = VER_0,
>          |               ^~~~~
>          |               VER_0_1
>
>
> vim +193 drivers/thermal/qcom/tsens-8960.c
>
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  175
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  176  static int init_8960(struct tsens_priv *priv)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  177  {
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  178    int ret, i;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  179    u32 reg_cntl;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  180
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  181    priv->tm_map = dev_get_regmap(priv->dev, NULL);
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  182    if (!priv->tm_map)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  183            return -ENODEV;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  184
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  185    /*
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  186     * The status registers for each sensor are discontiguous
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  187     * because some SoCs have 5 sensors while others have more
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  188     * but the control registers stay in the same place, i.e
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  189     * directly after the first 5 status registers.
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  190     */
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  191    for (i = 0; i < priv->num_sensors; i++) {
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  192            if (i >= 5)
> 69b628ac71f07d6 Amit Kucheria                2019-03-20 @193                    priv->sensor[i].status = S0_STATUS_ADDR + 40;
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  194            priv->sensor[i].status += i * 4;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  195    }
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  196
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  197    reg_cntl = SW_RST;
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  198    ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  199    if (ret)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  200            return ret;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  201
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  202    if (priv->num_sensors > 1) {
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  203            reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  204            reg_cntl &= ~SW_RST;
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  205            ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  206                                     CONFIG_MASK, CONFIG);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  207    } else {
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  208            reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  209            reg_cntl &= ~CONFIG_MASK_8660;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  210            reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  211    }
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  212
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  213    reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  214    ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  215    if (ret)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  216            return ret;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  217
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  218    reg_cntl |= EN;
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  219    ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  220    if (ret)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  221            return ret;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  222
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  223    return 0;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  224  }
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  225
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  226  static int calibrate_8960(struct tsens_priv *priv)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  227  {
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  228    int i;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  229    char *data;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  230
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  231    ssize_t num_read = priv->num_sensors;
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  232    struct tsens_sensor *s = priv->sensor;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  233
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  234    data = qfprom_read(priv->dev, "calib");
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  235    if (IS_ERR(data))
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  236            data = qfprom_read(priv->dev, "calib_backup");
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  237    if (IS_ERR(data))
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  238            return PTR_ERR(data);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  239
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  240    for (i = 0; i < num_read; i++, s++)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  241            s->offset = data[i];
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  242
> 6b8249abb093551 Srinivas Kandagatla          2019-08-23  243    kfree(data);
> 6b8249abb093551 Srinivas Kandagatla          2019-08-23  244
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  245    return 0;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  246  }
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  247
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  248  /* Temperature on y axis and ADC-code on x-axis */
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  249  static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  250  {
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  251    int slope, offset;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  252
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  253    slope = thermal_zone_get_slope(s->tzd);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  254    offset = CAL_MDEGC - slope * s->offset;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  255
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  256    return adc_code * slope + offset;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  257  }
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  258
> e604bdd2a7e1087 Amit Kucheria                2020-03-12  259  static int get_temp_8960(const struct tsens_sensor *s, int *temp)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  260  {
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  261    int ret;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  262    u32 code, trdy;
> 8b71bce407b3f13 Amit Kucheria                2019-11-01  263    struct tsens_priv *priv = s->priv;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  264    unsigned long timeout;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  265
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  266    timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  267    do {
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  268            ret = regmap_read(priv->tm_map, INT_STATUS_ADDR, &trdy);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  269            if (ret)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  270                    return ret;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  271            if (!(trdy & TRDY_MASK))
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  272                    continue;
> 69b628ac71f07d6 Amit Kucheria                2019-03-20  273            ret = regmap_read(priv->tm_map, s->status, &code);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  274            if (ret)
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  275                    return ret;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  276            *temp = code_to_mdegC(code, s);
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  277            return 0;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  278    } while (time_before(jiffies, timeout));
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  279
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  280    return -ETIMEDOUT;
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  281  }
> 20d4fd84bf524ad Rajendra Nayak               2016-05-05  282
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  283  static struct tsens_features tsens_8960_feat = {
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15 @284    .ver_major      = VER_0,
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  285    .crit_int       = 0,
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  286    .adc            = 1,
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  287    .srot_split     = 0,
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  288    .max_sensors    = 11,
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  289  };
> efea0f0570b6b58 thermal-bot for Ansuel Smith 2021-04-15  290
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

What happened here? This doesn't seem right.
