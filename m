Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2135A550F32
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 06:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiFTEYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 00:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFTEYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 00:24:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C9863E1
        for <linux-pm@vger.kernel.org>; Sun, 19 Jun 2022 21:24:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p5so3322504pjt.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Jun 2022 21:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NbeaABUtMNahOUHYDPACaxK36rxwA30aK2dksnmaa1Y=;
        b=f+5YWrVM/TrNZwpd73RB2OS/Otrz8Eh4FZYYDKm+DTzkkwSqftNgiIXzZJfCkxNt44
         MmLlFibAyvQwLGkbzuBCKwELL1DPimPXYtMho5tRHp8utRbX1XA6LvNoCgZkfz/VMrBC
         4n8OZrTuWJFZ/EI9x4quwSXyvTmD5zAYusNEgHgZS+WJEKhIhECUohi6xCtPODTQkG2f
         E99cinkE5vFw+E8oVEgfXYNZZKlDZgfrDUF/X9UApAYmgrTM3l5h1buy4OCDYROvpo5d
         fzZmzQ7iuIUPTeZhxEZkN3VqmObKpjM+VpPoRiN1W0w6ciJNY3BzEE8KiG82D3OCamCm
         Yjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NbeaABUtMNahOUHYDPACaxK36rxwA30aK2dksnmaa1Y=;
        b=7loZF8c/immSSzruJL4woSCB1ZcMDw2OInct3QROoCZpxreT2Iszt5fXWvNgb1zM3N
         1S5PBOtEGwMLcJUbh1in2VLKBtGIkrfx3+FT17g/lWW2Rnn6Je74Das0EmowS2z4Efzt
         5MevndBHj42Xzejz4SlRe6DDUR5Y3KJN1ZufjVBQL4xjlVhZTyxeOSfBaeetVzAxG+iS
         sFF7JPxLVQuSCTYDQkZ6dCKesQte+oVW/P2n8xARiwAfZYOJ1U9rDJCF0E2OUfOJGXoC
         hO5UtvPDOw/pykGpy5fnmRztxNUifiqByjjYRymX7q+xMxLpHnlQJZd+LwIOEWpmAiSZ
         dblg==
X-Gm-Message-State: AJIora+MarfIaEicNWPZODi3LPtMo266o1vhZrsCLrzam43XaLLXrUUa
        quZow3HQpxnCG+eOlt1STMhNUw==
X-Google-Smtp-Source: AGRyM1s8H06og2dT4xuDyKrTJYQ9E1fL56N9Q/qWm8V+M3GeJ/uuD8KaTU07QrlNrQ4RbpgTK6Z7cw==
X-Received: by 2002:a17:90b:1e06:b0:1ec:b396:7468 with SMTP id pg6-20020a17090b1e0600b001ecb3967468mr1059691pjb.63.1655699057668;
        Sun, 19 Jun 2022 21:24:17 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090aae0900b001ec8c53544esm3205608pjq.46.2022.06.19.21.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 21:24:17 -0700 (PDT)
Date:   Mon, 20 Jun 2022 09:54:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "yiyang (D)" <yiyang13@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] cpufreq: Fix reserved space in cpufreq_show_cpus()
Message-ID: <20220620042406.33wyh5frl7ypg7at@vireshk-i7>
References: <20220521063534.138930-1-yiyang13@huawei.com>
 <20220524071041.4aw3cfo3x5wphziy@vireshk-i7>
 <CAJZ5v0jCx0v-Q2=aW4nSSAHHajUnLdVtQMe3w1cX1w-o=mSesg@mail.gmail.com>
 <CAJZ5v0g-rCSd+S4YPBR8Jv2PqePhjQd0K97Rj2+TX3OrWAP0NA@mail.gmail.com>
 <20220615045608.pwranz6b633xmymf@vireshk-i7>
 <0af83072-9aef-14fd-f52f-a3230f6df148@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af83072-9aef-14fd-f52f-a3230f6df148@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-06-22, 18:32, yiyang (D) wrote:
> What can i do for this patch?

Resend it after rebasing on pm/linux-next.

-- 
viresh
