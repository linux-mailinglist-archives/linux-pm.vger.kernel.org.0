Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546051D743
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 14:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391629AbiEFMHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391620AbiEFMHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 08:07:13 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8376473D
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 05:03:29 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id m128so12441810ybm.5
        for <linux-pm@vger.kernel.org>; Fri, 06 May 2022 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJe61iFzcBkDHHBgwbqNO2U+CJ7UpSh7Y5S1j727pJ0=;
        b=IxK4YTNfmwgHKR7FTZ20P2HVFQz/yuwiqdIwfXox3nUVWYczPlpm6PFaN1ZimtwW7Q
         U/F/Z9ntCYv9PMOnLePu/tNoYaOZEgfH/kueSoaY/OPM9iQm9hULzFhmLGkrSr26cgNb
         6plXOvVcG4cMeLA4KkpmZuIRLkw0VRRXNKoLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJe61iFzcBkDHHBgwbqNO2U+CJ7UpSh7Y5S1j727pJ0=;
        b=1gAdsNqqS+8DRjwt2JCAuNLS1qpIvyJG3aT1AFFYW0ihVwA8+23YhLrPJropu1off6
         c8RCI/i8ljB925u7KWdKVNB1l2SD/YBybG+tW/4bPQ/ZmEO7CViQKt6DJvxZdcjAnt6M
         5mGRqkIsrP5T1PYM5TH7O7JYNsSOotYpJmKelko3gwJj1ciA+He20QZIyaB6J8Qmog1i
         hu3gcEDyGuN4Iq7VBQ0m/yhKutHFr6NjAnnFjAIXYu/qbSwMLmew1kaMQH1JMpk3dQsb
         OoG266FjXbQV37F8gFYh2/am2Ic/ThbXjYy4fHcot9jeOBVkhrFJXwHDADTeLxHXaekD
         R/Xg==
X-Gm-Message-State: AOAM532nH+IiNOzui6Hp/N1gnyFfxQX8QztdrO8hLqrdMLw44DD9ZKaE
        zmdq80G7soMVoJB1TUlOHMjPzDrf0bQt/5d1Bf0xuw==
X-Google-Smtp-Source: ABdhPJx9Axl6G6Vn89Khu54TfUr+9woAZDpNbcGfw1wHALNejHYK/qeoxm9wPu0kPDc+oQU03cSeWaDg0HqV6PFxk5c=
X-Received: by 2002:a25:4c2:0:b0:648:6a77:5da0 with SMTP id
 185-20020a2504c2000000b006486a775da0mr1878515ybe.203.1651838608247; Fri, 06
 May 2022 05:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220425125546.4129-3-johnson.wang@mediatek.com>
 <202204271737.oAuTwqZH-lkp@intel.com> <a72b6333be0d8a2065477e47222c309a0d520fd4.camel@mediatek.com>
 <abc836d8-b7da-c9da-6936-567df7206ca5@intel.com>
In-Reply-To: <abc836d8-b7da-c9da-6936-567df7206ca5@intel.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 6 May 2022 20:03:17 +0800
Message-ID: <CAGXv+5Hpcm12h0LNPaQ+svdtCa5AaMkC=qS8WaShWQc2oxQfJg@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v3 2/2] PM / devfreq: mediatek: Introduce
 MediaTek CCI devfreq driver
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Johnson Wang <johnson.wang@mediatek.com>,
        kernel test robot <lkp@intel.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 28, 2022 at 7:39 PM Chen, Rong A <rong.a.chen@intel.com> wrote:
> On 4/27/2022 6:11 PM, Johnson Wang wrote:
> > On Wed, 2022-04-27 at 17:25 +0800, kernel test robot wrote:
> >> Hi Johnson,
> >>
> >> Thank you for the patch! Perhaps something to improve:
> >>
> >> [auto build test WARNING on robh/for-next]
> >> [also build test WARNING on linus/master v5.18-rc4 next-20220427]
> >> [If your patch is applied to the wrong git tree, kindly drop us a
> >> note.
> >> And when submitting patch, we suggest to use '--base' as documented
> >> in
> >>
> > https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMS_s9zEZ$
> >>   ]
> >>
> >> url:
> >> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Johnson-Wang/Introduce-MediaTek-CCI-devfreq-driver/20220425-205820__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMc1U_tqz$
> >>
> >> base:
> >> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMUzTprof$
> >>    for-next
> >> config: hexagon-allyesconfig (
> >> https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20220427/202204271737.oAuTwqZH-lkp@intel.com/config__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMaVRzbSL$
> >>   )
> >> compiler: clang version 15.0.0 (
> >> https://urldefense.com/v3/__https://github.com/llvm/llvm-project__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMRqw5IY-$
> >> $  1cddcfdc3c683b393df1a5c9063252eb60e52818)
> >> reproduce (this is a W=1 build):
> >>          wget
> >> https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMQLiD-i9$
> >>    -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          #
> >> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commit/98b34c0587837b0e5b880b11a52433f8f0eee19f__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMU5yd7Y2$
> >>
> >>          git remote add linux-review
> >> https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux__;!!CTRNKA9wMg0ARbw!wdyoWXNLBcYM97vMuNFQXZ9BaajEp-Kmh5-xrvU2Rlmb0o-b9tRvCD0cPzbLMW4ldtnH$
> >>
> >>          git fetch --no-tags linux-review Johnson-Wang/Introduce-
> >> MediaTek-CCI-devfreq-driver/20220425-205820
> >>          git checkout 98b34c0587837b0e5b880b11a52433f8f0eee19f
> >>          # save the config file
> >>          mkdir build_dir && cp config build_dir/.config
> >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> >> W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash block/partitions/
> >> drivers/devfreq/ drivers/iio/imu/ drivers/misc/lkdtm/
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> >>     drivers/devfreq/mtk-cci-devfreq.c:372:16: error: no member named
> >> 'parent_type' in 'struct devfreq_passive_data'
> >>             passive_data->parent_type = CPUFREQ_PARENT_DEV;
> >>             ~~~~~~~~~~~~  ^
> >>     drivers/devfreq/mtk-cci-devfreq.c:372:30: error: use of undeclared
> >> identifier 'CPUFREQ_PARENT_DEV'
> >>             passive_data->parent_type = CPUFREQ_PARENT_DEV;
> >>                                         ^
> >>>> drivers/devfreq/mtk-cci-devfreq.c:379:4: warning: format
> >>>> specifies type 'int' but the argument has type 'long' [-Wformat]
> >>
> >>                             PTR_ERR(drv->devfreq));
> >>                             ^~~~~~~~~~~~~~~~~~~~~
> >>     include/linux/dev_printk.h:144:65: note: expanded from macro
> >> 'dev_err'
> >>             dev_printk_index_wrap(_dev_err, KERN_ERR, dev,
> >> dev_fmt(fmt), ##__VA_ARGS__)
> >>                                                                    ~~~
> >>       ^~~~~~~~~~~
> >>     include/linux/dev_printk.h:110:23: note: expanded from macro
> >> 'dev_printk_index_wrap'
> >>                     _p_func(dev, fmt,
> >> ##__VA_ARGS__);                       \
> >>                                  ~~~    ^~~~~~~~~~~
> >>     1 warning and 2 errors generated.
> >>
> >>
> >> vim +379 drivers/devfreq/mtk-cci-devfreq.c
> >>
> >>     255
> >>     256      static int mtk_ccifreq_probe(struct platform_device
> >> *pdev)
> >>     257      {
> >>     258              struct device *dev = &pdev->dev;
> >>     259              struct mtk_ccifreq_drv *drv;
> >>     260              struct devfreq_passive_data *passive_data;
> >>     261              struct dev_pm_opp *opp;
> >>     262              unsigned long rate, opp_volt;
> >>     263              int ret;
> >>     264
> >>     265              drv = devm_kzalloc(dev, sizeof(*drv),
> >> GFP_KERNEL);
> >>     266              if (!drv)
> >>     267                      return -ENOMEM;
> >>     268
> >>     269              drv->dev = dev;
> >>     270              drv->soc_data = (const struct
> >> mtk_ccifreq_platform_data *)
> >>     271                                      of_device_get_match_dat
> >> a(&pdev->dev);
> >>     272              mutex_init(&drv->reg_lock);
> >>     273              platform_set_drvdata(pdev, drv);
> >>     274
> >>     275              drv->cci_clk = devm_clk_get(dev, "cci");
> >>     276              if (IS_ERR(drv->cci_clk)) {
> >>     277                      ret = PTR_ERR(drv->cci_clk);
> >>     278                      return dev_err_probe(dev, ret,
> >>     279                                           "failed to get cci
> >> clk: %d\n", ret);
> >>     280              }
> >>     281
> >>     282              drv->inter_clk = devm_clk_get(dev,
> >> "intermediate");
> >>     283              if (IS_ERR(drv->inter_clk)) {
> >>     284                      ret = PTR_ERR(drv->inter_clk);
> >>     285                      dev_err_probe(dev, ret,
> >>     286                                    "failed to get
> >> intermediate clk: %d\n", ret);
> >>     287                      goto out_free_resources;
> >>     288              }
> >>     289
> >>     290              drv->proc_reg =
> >> devm_regulator_get_optional(dev, "proc");
> >>     291              if (IS_ERR(drv->proc_reg)) {
> >>     292                      ret = PTR_ERR(drv->proc_reg);
> >>     293                      dev_err_probe(dev, ret,
> >>     294                                    "failed to get proc
> >> regulator: %d\n", ret);
> >>     295                      goto out_free_resources;
> >>     296              }
> >>     297
> >>     298              ret = regulator_enable(drv->proc_reg);
> >>     299              if (ret) {
> >>     300                      dev_err(dev, "failed to enable proc
> >> regulator\n");
> >>     301                      goto out_free_resources;
> >>     302              }
> >>     303
> >>     304              drv->sram_reg = regulator_get_optional(dev,
> >> "sram");
> >>     305              if (IS_ERR(drv->sram_reg))
> >>     306                      drv->sram_reg = NULL;
> >>     307              else {
> >>     308                      ret = regulator_enable(drv->sram_reg);
> >>     309                      if (ret) {
> >>     310                              dev_err(dev, "failed to enable
> >> sram regulator\n");
> >>     311                              goto out_free_resources;
> >>     312                      }
> >>     313              }
> >>     314
> >>     315              /*
> >>     316               * We assume min voltage is 0 and tracking
> >> target voltage using
> >>     317               * min_volt_shift for each iteration.
> >>     318               * The retry_max is 3 times of expeted
> >> iteration count.
> >>     319               */
> >>     320              drv->vtrack_max = 3 * DIV_ROUND_UP(max(drv-
> >>> soc_data->sram_max_volt,
> >>     321                                                     drv-
> >>> soc_data->proc_max_volt),
> >>     322                                                 drv-
> >>> soc_data->min_volt_shift);
> >>     323
> >>     324              ret = clk_prepare_enable(drv->cci_clk);
> >>     325              if (ret)
> >>     326                      goto out_free_resources;
> >>     327
> >>     328              ret = clk_prepare_enable(drv->inter_clk);
> >>     329              if (ret)
> >>     330                      goto out_disable_cci_clk;
> >>     331
> >>     332              ret = dev_pm_opp_of_add_table(dev);
> >>     333              if (ret) {
> >>     334                      dev_err(dev, "failed to add opp table:
> >> %d\n", ret);
> >>     335                      goto out_disable_inter_clk;
> >>     336              }
> >>     337
> >>     338              rate = clk_get_rate(drv->inter_clk);
> >>     339              opp = dev_pm_opp_find_freq_ceil(dev, &rate);
> >>     340              if (IS_ERR(opp)) {
> >>     341                      ret = PTR_ERR(opp);
> >>     342                      dev_err(dev, "failed to get
> >> intermediate opp: %d\n", ret);
> >>     343                      goto out_remove_opp_table;
> >>     344              }
> >>     345              drv->inter_voltage =
> >> dev_pm_opp_get_voltage(opp);
> >>     346              dev_pm_opp_put(opp);
> >>     347
> >>     348              rate = U32_MAX;
> >>     349              opp = dev_pm_opp_find_freq_floor(drv->dev,
> >> &rate);
> >>     350              if (IS_ERR(opp)) {
> >>     351                      dev_err(dev, "failed to get opp\n");
> >>     352                      ret = PTR_ERR(opp);
> >>     353                      goto out_remove_opp_table;
> >>     354              }
> >>     355
> >>     356              opp_volt = dev_pm_opp_get_voltage(opp);
> >>     357              dev_pm_opp_put(opp);
> >>     358              ret = mtk_ccifreq_set_voltage(drv, opp_volt);
> >>     359              if (ret) {
> >>     360                      dev_err(dev, "failed to scale to
> >> highest voltage %lu in proc_reg\n",
> >>     361                              opp_volt);
> >>     362                      goto out_remove_opp_table;
> >>     363              }
> >>     364
> >>     365              passive_data = devm_kzalloc(dev, sizeof(struct
> >> devfreq_passive_data),
> >>     366                                          GFP_KERNEL);
> >>     367              if (!passive_data) {
> >>     368                      ret = -ENOMEM;
> >>     369                      goto out_remove_opp_table;
> >>     370              }
> >>     371
> >>     372              passive_data->parent_type = CPUFREQ_PARENT_DEV;
> >>     373              drv->devfreq = devm_devfreq_add_device(dev,
> >> &mtk_ccifreq_profile,
> >>     374                                                     DEVFREQ_
> >> GOV_PASSIVE,
> >>     375                                                     passive_
> >> data);
> >>     376              if (IS_ERR(drv->devfreq)) {
> >>     377                      ret = -EPROBE_DEFER;
> >>     378                      dev_err(dev, "failed to add devfreq
> >> device: %d\n",
> >>   > 379                              PTR_ERR(drv->devfreq));
> >>     380                      goto out_remove_opp_table;
> >>     381              }
> >>     382
> >>     383              drv->opp_nb.notifier_call =
> >> mtk_ccifreq_opp_notifier;
> >>     384              ret = dev_pm_opp_register_notifier(dev, &drv-
> >>> opp_nb);
> >>     385              if (ret) {
> >>     386                      dev_err(dev, "failed to register opp
> >> notifier: %d\n", ret);
> >>     387                      goto out_remove_devfreq_device;
> >>     388              }
> >>     389              return 0;
> >>     390
> >>     391      out_remove_devfreq_device:
> >>     392              devm_devfreq_remove_device(dev, drv->devfreq);
> >>     393
> >>     394      out_remove_opp_table:
> >>     395              dev_pm_opp_of_remove_table(dev);
> >>     396
> >>     397      out_disable_inter_clk:
> >>     398              clk_disable_unprepare(drv->inter_clk);
> >>     399
> >>     400      out_disable_cci_clk:
> >>     401              clk_disable_unprepare(drv->cci_clk);
> >>     402
> >>     403      out_free_resources:
> >>     404              if (regulator_is_enabled(drv->proc_reg))
> >>     405                      regulator_disable(drv->proc_reg);
> >>     406              if (drv->sram_reg && regulator_is_enabled(drv-
> >>> sram_reg))
> >>     407                      regulator_disable(drv->sram_reg);
> >>     408
> >>     409              if (!IS_ERR(drv->proc_reg))
> >>     410                      regulator_put(drv->proc_reg);
> >>     411              if (!IS_ERR(drv->sram_reg))
> >>     412                      regulator_put(drv->sram_reg);
> >>     413              if (!IS_ERR(drv->cci_clk))
> >>     414                      clk_put(drv->cci_clk);
> >>     415              if (!IS_ERR(drv->inter_clk))
> >>     416                      clk_put(drv->inter_clk);
> >>     417
> >>     418              return ret;
> >>     419      }
> >>     420
> >>
> >
> > Hi "kernel test robot",
> >
> > Thanks for your review.
> >
> > This patch is based on chanwoo/devfreq-testing[1]
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing
>
> Hi Johnson,
>
> Thanks for the feedback, we'll take a look too.

I think the last patch on that branch might be broken.


ChenYu
