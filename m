Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9357B6D3C75
	for <lists+linux-pm@lfdr.de>; Mon,  3 Apr 2023 06:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjDCEaz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 00:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjDCEae (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 00:30:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFE4BDD9
        for <linux-pm@vger.kernel.org>; Sun,  2 Apr 2023 21:30:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ix20so26812188plb.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Apr 2023 21:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680496230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GIkKtSugYhrxQ9k97IUdK4hi54+2VMdRy2bVcwI4a6w=;
        b=opeBmlX5MJU33ApeMw+mVxCX503Zk2aZaCQUBDMl+U2Y1SCEtILFvrVuHIz0i3/6Qz
         bbGZVHdf1jOwY9B/gLdYprAFpt+Tbk4yuedc/kPejkA6KKa1oMRSY7B9ovbh4p6Qg3pe
         rC+KD6Jc0vCqgeWCbBJZzC0R7JAuwKoZ2b8Pd4Kp77BEG06GUOjViUWQmNAhw0a3l9wJ
         w7QPBVrlcFyMgvnDsGZTTDCYxjd9mm9xcrVc24NX9wjXNoa1W1avD4JUVUIUgQqhkshP
         xlZr3hXvj2MQM/CtFMXkSilErNfcUsrM+Hry1pxyduaDg/PB0tcI30QvYL46mdJWuWtS
         DnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIkKtSugYhrxQ9k97IUdK4hi54+2VMdRy2bVcwI4a6w=;
        b=jKEtpRKLEO6exdJecQVP9ZzoQ1IshHMquaC0AAD91eNp5CGdt9+e9E3wrzb7O82wLy
         Y1bAmViqoMMi8EwG9jB4haO0jUqDVd+MhEltkdr88+Abl+CEdqXs66sCXrZmN82hF8pK
         xV7MoInBzsYVeAHWhypkXZHmKwZO43Hr/XAYSAdcbJhruFh0vgbpwwgyCyovTFqxbKy0
         qng5MUijM5XTqGcWZ91OICab5QCY+WUU6jWTxkxkYCs/2ceBNgaAmd9ly1M6Utik02JK
         zn+w/FLfCOeZftr4QGjeEB5RdC4f7KioIgCgTkIjjau3Eu+3qtQyLf0/J3I4NL4UFiyF
         U+kw==
X-Gm-Message-State: AAQBX9dOIQGTF886Rh98S772H0MUZ7zbneEUS1Yz/9mCNW0WA/ExGKbZ
        +pN6VGakIF+2dxAwPeQUjF+eIQ==
X-Google-Smtp-Source: AKy350ayQ7a3TOiG7ZFJEW/ttmpveIdU5N0HRh3srRxWQXexmGk2c+/ilSte/+Z13GcB4E3lVpaZwA==
X-Received: by 2002:a17:90b:1d8e:b0:23f:37b6:48f4 with SMTP id pf14-20020a17090b1d8e00b0023f37b648f4mr38621349pjb.43.1680496230097;
        Sun, 02 Apr 2023 21:30:30 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090a678400b0022be36be19asm5001971pjj.53.2023.04.02.21.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:30:29 -0700 (PDT)
Date:   Mon, 3 Apr 2023 10:00:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     cw00.choi@samsung.com, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
Message-ID: <20230403043027.xumo7bkbyg6nw2m6@vireshk-i7>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
 <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
 <20230224021713.stpcykx2tjkjwyti@vireshk-i7>
 <Y/hyf+/EqEeTu436@niej-dt-7B47>
 <20230227042349.3p2ijo6s6yyqc267@vireshk-i7>
 <CABymUCNBkr_65JHNVfbUGjxs6rhnj=eUyZ+5j6VtiDwqzLYtcA@mail.gmail.com>
 <20230227092953.ekh72r5h6xcqgusn@vireshk-i7>
 <CABymUCO4Gb-vALx=qa1q=QNfTJWoqNpT2r3J_xHxhGk7FZE0nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCO4Gb-vALx=qa1q=QNfTJWoqNpT2r3J_xHxhGk7FZE0nQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-03-23, 18:48, Jun Nie wrote:
> Viresh Kumar <viresh.kumar@linaro.org> 于2023年2月27日周一 17:29写道：
> >
> > On 27-02-23, 17:21, Jun Nie wrote:
> > > Sorry for not expressing it accurately. I should say devfreq devices
> > > pointers, just
> > > devfreq_virt_devs vs genpd_virt_devs. Then you know why I add devfreq-devs
> > > dts nodes below.
> >
> > Won't something like dev_pm_opp_set_clkname() would be enough here too ? We
> > already do this kind of work for clks and regulators.
> 
> Thanks! It is a possible solution. I will try to spare time on this as
> higher priority tasks
> are on my list.

I have applied first two patches. I would like to apply the third one
with some user code. I will wait for your code to merge that.

-- 
viresh
