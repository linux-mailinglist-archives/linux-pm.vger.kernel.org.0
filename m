Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392CC615C88
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 07:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKBGzA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 02:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiKBGy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 02:54:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B4D25EB6
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 23:54:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c24so15695035pls.9
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2022 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SAOkUsCOtaiUhMk86kQHicWY7yq03GggkInJiFKNa+Q=;
        b=MEzPbgg3wLi8HrCN3s9iVF+0j0Dc4kIb18s95oTCxTrDTyY+/m2vVdT/sUzuJxecn4
         Hzrno2UsQl5r3KZFn9b2YyR6ba5g+A4KBmbwC1fZ4Ad+luHhZA0i0AK/EJt4exBYhuC9
         jiBXxdr2rpgDbI1r+ec3LZmDbhrPuA8XdHHVIdRnWB+AfsVaDv5X9Kg9nCDSmKprYYCA
         4DCUHZRJaPiWGBZLOQ2k5PqDONrpf3VHnHSk4jM3kQChui4sC2Mp9b81qK3A/XCnQ7s/
         zY3PWdqhuE+CNAhJYlaKPliCWGxkmeMhHv4TEIQqj8oICpAASQAgg/LhD9QwBYZh1P/s
         fh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAOkUsCOtaiUhMk86kQHicWY7yq03GggkInJiFKNa+Q=;
        b=tgREJYK3ySinDBp7E4zk3ntxNjjGVX4TZshrewgaOMt7bwQ3P2738ZrY88HGoYgcGa
         r9+tSxjD0mKvkyNUNPL8j+6C9kUvMwl3MEIjNEbyZ7FzDBTTUlk3j8x4VNdUqbIgIiz/
         v3ZzFi5ry5YlYb2j2aL9KHjY0Z3Wo4NgrNkLip0BI6EDRlzB4AI8f/3q1MzoHvS1LsbD
         7ZgTpHC6rdk8P6njCHF+DgRAzvyIZGjzCew63ffwD2EjPKGBP1a1QEt0XY2ZOtCkLjkF
         yeP+AHnMoZ9KNm96F2cXr7IeDzeMI1bQRQofixF9y3gu5DlaYSlpsvWKDMpyYGENLuJR
         l6sA==
X-Gm-Message-State: ACrzQf2atsFzcAWkIP0siMAP2JKUbpicmk1Nv0UpKMsKmlV6iBw1aiLz
        MlkBVwGUEiQwKOQlrrQtvN2Y
X-Google-Smtp-Source: AMsMyM4rGLfxyF9kzZE9+p2ectELM6qqF7ZVRIHqYdn6aPcQGYorkM+oB/Tc8aqySRcJD/Zehi5olA==
X-Received: by 2002:a17:902:ab89:b0:186:7cfc:cde8 with SMTP id f9-20020a170902ab8900b001867cfccde8mr23636607plr.9.1667372097729;
        Tue, 01 Nov 2022 23:54:57 -0700 (PDT)
Received: from thinkpad ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902f64a00b001769cfa5cd4sm7505787plg.49.2022.11.01.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 23:54:56 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:24:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221102065448.GA10650@thinkpad>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
 <20221025073254.1564622-8-manivannan.sadhasivam@linaro.org>
 <20221102042849.q3qnaoebeudpbpnv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102042849.q3qnaoebeudpbpnv@vireshk-i7>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 02, 2022 at 09:58:49AM +0530, Viresh Kumar wrote:
> On 25-10-22, 13:02, Manivannan Sadhasivam wrote:
> >  	for (i = 0; i < num_domains; i++) {
> >  		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
> > +		static struct clk_init_data init = {};
> 
> Why not make this part of a driver level structure instead of static ?
> And what will {} do ? Initialize to 0 ? static would have already done
> that.
> 

Good catch! "static" is not needed here.

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
