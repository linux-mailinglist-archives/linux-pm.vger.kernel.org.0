Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257C6B38B0
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 09:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCJIb3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 03:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCJIbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 03:31:17 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC3DBB5C
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 00:31:01 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-53852143afcso84456307b3.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csGLQ+HJvr4LxzgGWY6CNMVw5Or5HiSrrGSUyV9nTeY=;
        b=qqVZrbljiVaxCDq7PK4DMNod9UIjiHSEeWRPRsWMxPQdZvr+AyT0Ppd6CVYruMFA1r
         YzNlMxj2hjWNrrQC4KKqG1H0E3eXgPUU1LBCZ3ASMOkKBzxAc4cI/4O5VVrX1OIRW60T
         mymVrUmxpMTGde0v61S810KiHJcAfGrlqyZ7VE7yMfnvANX3cyIwI5SR0OElMY7mvfs4
         2ATkAKGpEITCiGh5b4o5+ZFIA+OYQBkz4OZtiA3bIN2+lVAEmrMrz5mMnnFLxN/VdOIc
         ziXnla55HBB4GW+525DbP+vSdZziZDTQWHE8PHIfqJuK67egL2z8umDmc/sPN85RBzr/
         y2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csGLQ+HJvr4LxzgGWY6CNMVw5Or5HiSrrGSUyV9nTeY=;
        b=OEoFcEFiB3I2FNBx+fBRe9gVzLQ0BPtUublvVAI3bfbVgbTu+GRLoA6V+iZk9/akI/
         Dttu8JMDBLfBwH9QGZbrhhxO624GdcLMd6LccKyd0np1bIg+jby89g1WwpI++TNEsdKN
         1iylRGX3BlYwvoVJb7yOjneoPztrxCVH5toxOqMOcvAma23QhedDfq9t96z1WVLq/9dh
         AJQEUcsNu3ltDHbL98G8aRi160Q6YkfsZhyUdQUpum8Q9XitME99b3Zsn/sXUNUerxyH
         0QC5xV8mYTWWx9iq+/jZ2FC+uQRHYGakiRFAHDCzGYOrqTGXn+GXw0gBcSfS675+685w
         w6KQ==
X-Gm-Message-State: AO0yUKXzOAAZ/UWjfYNLCGmjxCFs1LfTc4gMb5gBUSUBGpOVoQndaKEw
        OFj7C8i3a58aHzYUTfmTcv5HsV76COOXFrQVo4foSg==
X-Google-Smtp-Source: AK7set/prggt4Pz8CJxuZSir5+zLD32kXIut3Cm9wOY9Y9/ajINMubM9mi6k/4gvyZeaMxR3Z3lPoktZBE3cRrALz7E=
X-Received: by 2002:a81:a9c6:0:b0:52e:f77c:315d with SMTP id
 g189-20020a81a9c6000000b0052ef77c315dmr1128456ywh.3.1678437060520; Fri, 10
 Mar 2023 00:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-9-sre@kernel.org>
In-Reply-To: <20230309225041.477440-9-sre@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 09:30:49 +0100
Message-ID: <CACRpkdbsBzmTmEus=CnDw41WKS799kXmpekD8NY8OWkeR6HwBA@mail.gmail.com>
Subject: Re: [PATCHv1 08/11] power: supply: generic-adc-battery: use
 simple-battery API
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:

> Use standard simple-battery API for constant battery
> information like min and max voltage. This simplifies
> the driver a lot and brings automatic support for DT.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

That's neat.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
