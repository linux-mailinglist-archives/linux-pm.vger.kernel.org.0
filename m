Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9E207671
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbgFXPCe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404255AbgFXPC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:02:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C85BC0613ED;
        Wed, 24 Jun 2020 08:02:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e15so1744084edr.2;
        Wed, 24 Jun 2020 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joaqSzO9YrunPdmQExA2g6tAJBLWEu7X/4bAmZ8Um/4=;
        b=fGLKEPfmpfyDVfYFXgXYsN+ra45eqMzfoxlE5fEQq2E/nJlHkb3aLLEjASyTdxD0Jh
         +azO0HVFjVl2/2A/s38XUzjfiLxD9o7Nlu0Mw+VBWhW6rymHPfENV5SXmIstGF3ITmL5
         lpiHMvnjinZehwBoLMIs4FZv2qc6PRH5il+rtve0m8NIj/csmPfzKCyMnuV2PaWONWJt
         uvZM4HPJ4IPqUXK7qJA5fRfSKYpcoTO44cEXFLc30/fnJpzKaLiXjo7QQ+Y97+D5I+RA
         pQWfrIqsaosnoRb470LdJUW7z15by2RA49MHwX/B8AidCSBEDUPfUTb6E6T/QWxNkcVQ
         FTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joaqSzO9YrunPdmQExA2g6tAJBLWEu7X/4bAmZ8Um/4=;
        b=LJgFstwVId7Gj1PEa9S0JUX669uDIiMYeZGsAdJ8yrTh0rHYpCn0DIYgY8pkbGCNyD
         Lf7I7l9DMs1jxKQm/tK3/v/hUfdQASLUylPC8K1rC4QVCYW/hpNFL/XjjtMaUWCTTJTZ
         BCSzW1PYP8fpv/EG7BAyTBOjkhsleTRHTvUUB+29ViaAMrnudibv95mTF34SI9Bu95Bw
         AZjrRXPuXjUZ7DOmueWZo4x/TPewboC/VscsPY8sctsYdKhFnLPYpgSadLy+MYpANYt0
         1drfeZMM7FyASo68FyTsnD6JFsBmRToIi8D8i24IVrLq5YUyoip1XbKgmkRz7ZIhpBCt
         UogA==
X-Gm-Message-State: AOAM530iLMyTtY+HSvYnzrjQ4E9VO27dEmcBpjr1d4gz1OnQYT7H7Rdx
        bVkDtoM7BkXrucb8esFrPk9TRqTiB/Fj5ZEBd1UV3V10
X-Google-Smtp-Source: ABdhPJybRDss19kJA/nU6b6NvS3HVIs6RZo/E76NGJSVeOzB8R3k6aWf/LXpQbE9UooKYCG8cGulykoWdAXpdAGvXJ0=
X-Received: by 2002:aa7:c756:: with SMTP id c22mr27583864eds.239.1593010946270;
 Wed, 24 Jun 2020 08:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200623180832.254163-1-konradybcio@gmail.com>
 <20200623180832.254163-4-konradybcio@gmail.com> <CAHLCerOAM5j+gZWP9MUuGZ+TQfBg4Z=GoEdUfxBTwtEs5TqUuw@mail.gmail.com>
In-Reply-To: <CAHLCerOAM5j+gZWP9MUuGZ+TQfBg4Z=GoEdUfxBTwtEs5TqUuw@mail.gmail.com>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Wed, 24 Jun 2020 17:01:50 +0200
Message-ID: <CAMS8qEUT+Kdq-gqZn25X7W2V8HacuXFbeoTDz=N7C7MNpSfOHA@mail.gmail.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sdm630: Add tsens node
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Interesting, the downstream DTS only mentions the 0x010AD one..
Are you sure you're not looking at 636/660?

Regards
Konrad
