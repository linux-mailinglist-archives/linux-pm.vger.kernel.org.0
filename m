Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE352314DA2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 11:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhBIK4F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 05:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhBIKyC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 05:54:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56FC061794
        for <linux-pm@vger.kernel.org>; Tue,  9 Feb 2021 02:53:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h12so4769480wrw.6
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2021 02:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3tgfIWWSNsMJyV0k5Lpc0gdOlm8W65FCoKDdWIZ0Y2s=;
        b=PvkiBWedmJOGy6M63JOOzwOhvsrhB9pf/ZukrYKMSSNsa5v0FhhTB1LIK8ktSjizY0
         /9c5ib95omWBpUlzChqr/UVK+wlgt9E9LvTx6bAi/W54fhKenc3Nxaz8VP3Ea2nMKJ4/
         bntGoP7eGJmo2Jw0I339fOQjCPOUc8TYA2tvSKsShOM58wjRb6YWVKqSN4beU6pO6q5h
         BejnMg60fKoEfHtxFN4yZqmr4/PtWO+A9vHYxIZOFbjysfYynX4oaPYwSpl9THoXiJE6
         xpsEd+IcQLkmH9ZorD9pgYObAa5f7QSLyQdUZAl2ARxjQEpWC0Ydo8Vb/LGbbBfUbNzG
         QvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3tgfIWWSNsMJyV0k5Lpc0gdOlm8W65FCoKDdWIZ0Y2s=;
        b=a65PGpMgcCWWbLcuFASWWZfcrBZbehPX7ygRQfVF4daFj5NBzc8/M1ZYZyf+PblmbE
         gRHcXPFRV2Qxfj+oF/7R2cZoMJs4mkoOB602mYhfK3YXQP8F03egxcuW7XkqlQ1Ri/eI
         c4R4PMp67XO1NfwcD9oWwAGYjUKb/C6t7VbI7g7eX9/uSuctNAVWKVbq7Sq1ikhi7Qz8
         coQhUkSBXixOy2vZQCJUc6srK2xxeZnSGF5JAuuES5uBuY1MtUScQaGD96TZrhWc+dbw
         fZkPOOLsDvDsSUAlQm7fK6FlQiaaXLNvFn0uy26Qu0jz6FfqwA0gslUGfRFd9g0R0xOI
         g7ng==
X-Gm-Message-State: AOAM532m35mKxE87GFouKEPoGqF0cCg2k0OQncjXV8ZE67Aa+0EGHFW3
        RW1XmUsIi0FW+ZLmpjO6dROztA==
X-Google-Smtp-Source: ABdhPJw1mC6tVz3m3/HGZ9D9MhWlOJ16dhgADK3EpUH00Wj+E9WTLBicbYjMVzYlj2rgMNXgGwZj2Q==
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr24248657wrz.86.1612867999336;
        Tue, 09 Feb 2021 02:53:19 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z63sm4147635wme.8.2021.02.09.02.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:53:18 -0800 (PST)
Subject: Re: [PATCH v4 2/2] interconnect: qcom: Add SDM660 interconnect
 provider driver
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, marijns95@gmail.com,
        martin.botka1@gmail.com, MSM <linux-arm-msm@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201017133718.31327-1-kholk11@gmail.com>
 <20201017133718.31327-3-kholk11@gmail.com>
 <24ad51dd-ff54-35af-a7bc-92d8cfa30c48@linaro.org>
 <CAK7fi1ZC8F57WmDg57tAS=b++ewjPcMhBXmeuM7Cjqkp-5Zu9Q@mail.gmail.com>
 <55f89461-607a-8864-ff31-77d16448128c@somainline.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <d25e4301-a2b5-e212-9c88-a4c66936f4ee@linaro.org>
Date:   Tue, 9 Feb 2021 12:53:17 +0200
MIME-Version: 1.0
In-Reply-To: <55f89461-607a-8864-ff31-77d16448128c@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9.02.21 0:09, Konrad Dybcio wrote:
> MMCC got merged via the clk-next tree, so.. since this driver was
> technically in, say for the dt-bindings conflict.. can we get it
> merged again? :)

Thanks for the update! I'll take it for v5.13.

Cheers,
Georgi
