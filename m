Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037BB5B159B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 09:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiIHH05 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 03:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiIHH0w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 03:26:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A23AB4D3
        for <linux-pm@vger.kernel.org>; Thu,  8 Sep 2022 00:26:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y29so6229258ljq.7
        for <linux-pm@vger.kernel.org>; Thu, 08 Sep 2022 00:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LF14xoV7ofKttTcBdi+LKav8yvezlrH+J2rWTVvf/OQ=;
        b=NL7EBP7scniC5110h6lbEQucc1DlCz/xzdp65hnzWd0E1PsiQGhbG1lY7cAWfpbt9B
         qkK8BkSq03YvbYWxA47Tol7OhUcAwjwhDLcmA4jWJ8hHxYbk1lwkjzQwIQtHHiiB5DXI
         Fm9VctCVAnXJKfCUu7zPUDJ5guq+fh9lw6UsJuxB3DhOPDcti6gqoyyonUY5uTr9nN3i
         wfL+ZXMcByJJtVYzf8fzM5exZrseMJjQ+g5Fo93s9smufA+u16LTK/Hng4wbUBzBSxNw
         BrhG+c0e3B4T2ZYhxgHFXT7/Fss1AGB61jTCOKOJjTKhBmxjDnytgjARymuuL4cHEdl1
         fiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LF14xoV7ofKttTcBdi+LKav8yvezlrH+J2rWTVvf/OQ=;
        b=pm189Ltt0nFz1Oc8rWVO8lUmmWqHjx2HX99rED7dZIogjHilW/WWWow9FixEb9/1Tj
         QWkJgbzpL/sZYCs/0HChbk9i85Vzcily1jFCdQXwI0kVrSXbasFHAaUXHP4aDqHMXpH1
         EpVAufyqHoqJ1cpkkv4dmpxwFBQvxihGQaKdRohO0+O8SAbMwSeAsdXhVUN71StevIo7
         dtENtjo1h5xK6YQ5VTBmC/PKCKUdUMfw056YTcs2FgCntF2w8CZ0LKuAK5+6rlGz+Qr+
         /GOh+fivwd+E/VyP9w6bChnaeOCDUi7+TqPgT2XcBpk49H1kkw/UFz6vO+gop4ZPvLxq
         Nt7g==
X-Gm-Message-State: ACgBeo1RYQAdBKZP+Rekt0qB6P0/bIjcTtAerc30RR/Zc2xobOT03gsj
        1rYIkEEVVXFSEeNS5A724e4S/g==
X-Google-Smtp-Source: AA6agR4GpbjANjRRB/mggPAAMnjTCBrBoQ3zs7xDo36rYSrtHcx43GjsfBpcNuT6ZlDcZ53RODXr4g==
X-Received: by 2002:a2e:9a97:0:b0:26b:3f4f:cb90 with SMTP id p23-20020a2e9a97000000b0026b3f4fcb90mr807088lji.137.1662622009507;
        Thu, 08 Sep 2022 00:26:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b0048b0975ac7asm262844lfo.151.2022.09.08.00.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 00:26:49 -0700 (PDT)
Message-ID: <37b21772-c128-36bb-dbc1-5047b2a82773@linaro.org>
Date:   Thu, 8 Sep 2022 09:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220831081715.14673-1-pali@kernel.org>
 <9a71a2f3-97f6-f3ac-8852-1d3da1a50370@linaro.org>
 <20220907163331.zoumcdmmarnbkmm5@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907163331.zoumcdmmarnbkmm5@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/09/2022 18:33, Pali Rohár wrote:
> On Wednesday 07 September 2022 14:38:42 Krzysztof Kozlowski wrote:
>> On 31/08/2022 10:17, Pali Rohár wrote:
>>> This new optional priority property allows to specify custom priority level
>>> of reset device. Prior this change priority level was hardcoded to 192 and
>>> not possible to specify or change. Specifying other value is needed for
>>> some boards. Default level when not specified stays at 192 as before.
>>>
>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>
>> Thanks for the changes. Explanation looks good.
>>
>> I sent a patch adding the common schema with priority. If it gets
>> ack/review from Rob and Sebastian, please kindly rebase on top of it and
>> use same way as I did for gpio-restart.yaml
>>
>> Best regards,
>> Krzysztof
> 
> Ok, so just by adding "allOf: - $ref: restart-handler.yaml#" right?

Yes.

Best regards,
Krzysztof
