Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B77E04FB
	for <lists+linux-pm@lfdr.de>; Fri,  3 Nov 2023 15:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjKCOtn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 3 Nov 2023 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKCOtm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2023 10:49:42 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA6134
        for <linux-pm@vger.kernel.org>; Fri,  3 Nov 2023 07:49:36 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b2ef978011so144509b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Nov 2023 07:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699022976; x=1699627776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWpN2CKUQQhOxwg/Tn7CkiA50hVAW++QgcDuiTW0xOI=;
        b=ioVEXMRKcqQtE6NUdUcFnX5gXt2EP2vk28UpIunmY+TKFHGbmNk3WcQ0y03fFMs8xx
         PXXB0QklP5u+JImM4F3QWqUxLDafydbrprZvJbfX/5W4O5VxJt4p7iy3NczQXFH2WsbZ
         jplS2PGA45oKkQzHpeOf1XrZVyGBwCFTJxzbOVUPtclSBOIq3YCzzYb3Z/QtHn1me8ym
         emBhTiMb9gY1Y1lnPThHx2luMbo8QBpZyI8/ocGlroRJSnJuJ+9CRAdKBLUYue5iebi1
         LWD5v8yeBjEXYNh9jGp9/Uwjo8viWPfh14rrhaJrE2BpFXvWzyexGxot1W9xha4qU+pk
         Q74w==
X-Gm-Message-State: AOJu0YyR0dQNbNKoGPboXfq/wwIgtDu+J+mE985R56bOj8SwNOD2R7eX
        TLayObRAf5ISLiWoyuofEIfNilWtQHFJvw/NvP0K4sE0
X-Google-Smtp-Source: AGHT+IFND7KzEu/tTeUl23y+u3Iu+lk3EeL8+cI1DnsCW509fPlVsCVGTRpTgfMaf2C+/OcIbyvMvmtvnfysl4ZG/oQ=
X-Received: by 2002:a54:4518:0:b0:3b2:e224:73d0 with SMTP id
 l24-20020a544518000000b003b2e22473d0mr20172407oil.5.1699022975887; Fri, 03
 Nov 2023 07:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231102054551.rah3brlwv7457kzl@vireshk-i7>
In-Reply-To: <20231102054551.rah3brlwv7457kzl@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Nov 2023 15:49:23 +0100
Message-ID: <CAJZ5v0jQErrJUJKdDsm_7dirC0qxRzbA3g5YTdPFBDh1LHQuZg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.7-part2
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thu, Nov 2, 2023 at 6:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> I was waiting for some dependency patches from ARM SoC to land in for this.
>
> The following changes since commit 038ef0d990a0a5fbc2024084f51e8af7d9bc95a2:
>
>   dt-bindings: cpufreq: qcom-hw: document SM8650 CPUFREQ Hardware (2023-10-25 15:51:22 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.7-part2
>
> for you to fetch changes up to 5b5b5806f22390808b8e8fa180fe35b003a4a74d:
>
>   cpufreq: qcom-nvmem: Introduce cpufreq for ipq95xx (2023-11-02 11:04:53 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.7
>
> - Add support for several Qualcomm SoC versions (Robert Marko and
>   Varadarajan Narayanan).
>
> ----------------------------------------------------------------
> Robert Marko (1):
>       cpufreq: qcom-nvmem: add support for IPQ8074
>
> Varadarajan Narayanan (2):
>       cpufreq: qcom-nvmem: Enable cpufreq for ipq53xx
>       cpufreq: qcom-nvmem: Introduce cpufreq for ipq95xx
>
> Viresh Kumar (1):
>       Merge branch 'cpufreq/arm/qcom-nvmem' into HEAD
>
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   2 +
>  MAINTAINERS                                                  |  12 ++
>  drivers/cpufreq/cpufreq-dt-platdev.c                         |   3 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c                         |  60 ++++++++++
>  drivers/firmware/Kconfig                                     |  32 ++++++
>  drivers/firmware/Makefile                                    |   2 +
>  drivers/firmware/qcom_qseecom.c                              | 120 ++++++++++++++++++++
>  drivers/firmware/qcom_qseecom_uefisecapp.c                   | 871 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/firmware/qcom_scm.c                                  | 394 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/socinfo.c                                   |  11 ++
>  drivers/soc/qcom/wcnss_ctrl.c                                |   1 -
>  include/dt-bindings/arm/qcom,ids.h                           |   5 +
>  include/linux/firmware/qcom/qcom_qseecom.h                   |  46 ++++++++
>  include/linux/firmware/qcom/qcom_scm.h                       |  22 ++++
>  include/linux/ucs2_string.h                                  |   1 +
>  lib/ucs2_string.c                                            |  52 +++++++++
>  16 files changed, 1633 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/qcom_qseecom.c
>  create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c
>  create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h

Pulled and added to the linux-next branch in linux-pm.git, thanks!
