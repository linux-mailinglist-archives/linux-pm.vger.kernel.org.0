Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A524A7A98B0
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjIURvi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjIURvS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 13:51:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1795C5A03C
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:21:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso524734466b.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316861; x=1695921661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uxubhSOYRKOBgFVb2nJokjnsajJqcWLd3vDjsGmIJY=;
        b=NGoNxqvE7VivvGrew4BcwIk0SYiasQx02erL8rKEfxMcRoetJ/fDkNszESVgB+8WXu
         WZfiJwnYp4sJQyBa/6dQjazT3dAZ6z/lqTHYGiacJoLX1UgNijiIVqvChEqAi2N+UqcL
         pMhY8ziuAqdksvrQgKd9YMagn31cBgIiAIXTXEw8ELUKLSLDbnv+R4SBBCUNMlW7CoOp
         dnZNQ4eZ/wmmU7nwBtrt6uhF3MlbSbKZtrfWKAAmuLqjetO7/9iDqyfR0jVxFSBQ4TgU
         vdBOCnBEu85qC/fIEwVYx8bhTbVFauejTG+BPdh2VIlgy3RiJMUWB6N+P8fFYj6qgwRG
         Gqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316861; x=1695921661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uxubhSOYRKOBgFVb2nJokjnsajJqcWLd3vDjsGmIJY=;
        b=TJIjHmS0jH9vcssltx87OGVr0VeWrghVbsbL8oyH1zOb3jwnc9GvU4lrsYl1Go8P7u
         vyXiun3tFinYNAO5Vvu2gCeZgVUl1yTP7hJh71bPGITb+Vo23GQpfkHBkShW/Uhs0ySR
         s2A5oODrjwtFdPbXdgVIS7uO4zssgrj+D0SlVDxMosCuuNbblHw8s+vLUBU9z5OJHn/1
         7e6ROJdm02S36es/3HFz9ydJOMzLGYlyjHVaLY/zvsVYqcGhG7jxnvRs7VOFFT5y2cXL
         GUoL72zTnYNg8tJghr8V1vT8axZ5T7my4zkCLyhEd29MLMkGkNuNhdREMJAvshQtKjVk
         LfGA==
X-Gm-Message-State: AOJu0YzmrmUMhWpM4TshyN57uzwNUHF7O1SRZ7pwLVd6IJNZeKKbZBmb
        9dDwKazaP1nIGHA0To2aexsEQDBTGwKVoZpeKVzXFw==
X-Google-Smtp-Source: AGHT+IGPVfoflUP3NlCWwDzwylQtmI+2m3tAC7GFYclWCJd5Ehn+hZ+GXl/jM794pw9McnRpGwN/BQ==
X-Received: by 2002:a17:906:31da:b0:9ad:f60c:7287 with SMTP id f26-20020a17090631da00b009adf60c7287mr7118902ejf.28.1695290788801;
        Thu, 21 Sep 2023 03:06:28 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b009ad778a68c5sm812501ejb.60.2023.09.21.03.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:06:28 -0700 (PDT)
Message-ID: <4ac45fc9-1583-a71f-7c75-76ae6c882e67@linaro.org>
Date:   Thu, 21 Sep 2023 12:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: mediatek: add mt7988 lvts
 compatible
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230920175001.47563-1-linux@fw-web.de>
 <20230920175001.47563-2-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920175001.47563-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/09/2023 19:49, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7988 lvts application processor.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

