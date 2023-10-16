Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F77CA563
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJPKbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 06:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJPKbQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 06:31:16 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7006DB4
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 03:31:11 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79faf4210b2so163014639f.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697452271; x=1698057071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHWSQJKtMXCWVI/E5eOzEROfLgP71p7LecbnV+U6P7I=;
        b=Q+OnLR+dwsjVt5SEMdoojG9bToZK5YjdGubuH/V9MrQ3r9WIhk/49VfHVgFYghHXfx
         vctW6YD5292QAJA9xBKW39nqJ07RGfrCx/B2Qpak+04beRk5dU8DgOGEk4cZrvefgDAk
         xJTToMWmpnI5BnYI86InACCT8EFDve161eycIuXcDE3SCaXT72/JiTjWIa2q/W+nTIpt
         EhSq1MNgYyCn8vGXdclHLvTwen33lune0j0TOV8cVlU+XoJ2My9LP8TTlkk1qmWZEqeC
         UwXsBn3aORiWR+lQmNvOowMkEol4ACqQhTsF74GRwxDMhpw0XuO2uiPwwgTUShbdZr/O
         khsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452271; x=1698057071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHWSQJKtMXCWVI/E5eOzEROfLgP71p7LecbnV+U6P7I=;
        b=vOG9YoWPaCNKtcMAb5Abz31oFBMKPwZO863WyQaFV2B1TQg5VvYLz5qoWBOSAS14Np
         nSDAd6CRoylX4JbKFftrPMtgBPVos3uQf4uI4Jrjna791re7DwazJPibEu0FR7Rudpd7
         vtDK/lpW3QgYYtJtXcgEqwsFQUAlqs/JLUaFzVhmfOKMIfEW3kZkEPnFQ4iJgn6rJlYI
         mHNXHWTL2d9qoDs0qbDIfc6KTEp3UgJoPzQEhUwO6CtZgx3XdC0oAHKIVFuPQs9WoIjd
         jQM9HIe0KCm2Q1fUnqXS4eow78niQX6ORILH+jJJ/A+RBuRr0XSQ4hLxSL1+8XkFrJqD
         Q+JA==
X-Gm-Message-State: AOJu0YyURWTj3LpviWD4g9PLZ1ckRm/SajaVF6IWNi2NdpUdtB8BA8Ii
        8n8LJlmu+3BN/j0ypL/b1hzpcg==
X-Google-Smtp-Source: AGHT+IHWr7fM55d01cKjE928H1Akt2xUw5mdHfzkkoOM8Wkiffh/9SIMwKwbsA0gswo63rEq1vbl6Q==
X-Received: by 2002:a5d:8713:0:b0:792:9a3e:2dd with SMTP id u19-20020a5d8713000000b007929a3e02ddmr34733470iom.3.1697452270730;
        Mon, 16 Oct 2023 03:31:10 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id j18-20020aa79292000000b006875df4773fsm17789509pfa.163.2023.10.16.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:31:10 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:01:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, rafael@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
Message-ID: <20231016103106.kyeritota2mnutcm@vireshk-i7>
References: <20231013172033.3549476-1-robimarko@gmail.com>
 <20231016033202.i54nequofzea6mfd@vireshk-i7>
 <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7>
 <CAOX2RU5paPXyG-1Fbp+T9+Aycwno9DQ8ugMwUr_8iNhhc3HiHA@mail.gmail.com>
 <CAA8EJpq9=dtemYLCeL8=+q1x_i8Gp2duMSAo90ZttgaejBXCdg@mail.gmail.com>
 <CAOX2RU6K7h8Xc0SGK2CeOCaAaimKRf9eqhMYAaySXxQLZiUNtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU6K7h8Xc0SGK2CeOCaAaimKRf9eqhMYAaySXxQLZiUNtg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-23, 10:43, Robert Marko wrote:
> Ok, I understand now, the thing is that the ID-s were added for
> socinfo initially but recently
> I finally had somebody with access to the Oak HW so I added them to
> cpufreq as well.
> 
> What can I do to help this get resolved?

Rebased over Bjorn's commit (which he already sent in his Arm SoC pull
request) and applied your patch again.

-- 
viresh
