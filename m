Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351CB79AD31
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 01:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjIKXRG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354191AbjIKVws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 17:52:48 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056076BF;
        Mon, 11 Sep 2023 14:42:21 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3ab8e324725so330088b6e.0;
        Mon, 11 Sep 2023 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694468450; x=1695073250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1rskMG9E2Dj5/SRLejxHVPKSzfpoHVWY3HLrjdtxeI=;
        b=Y7q7OI6SVbBNsJX+noxObMOZ2Atcwke3sziKRBnbC3urDLzct3/xNGfUeW1AJ0rtxr
         BfNIs6O67uhJ70KQOv5opeeuoFL1oA6yyC95lsNf13UeOoFJH8Qkk3KC/0QbBUWfwA1L
         HzpOAzV6Y1rj0xKUYkwNTP0kYpGfl2WerY5T0DTP+sKuRfK9I+dP8aVzQdicADPVDFxc
         ke78bCfm7P1vID8nI2dhVkS3Hi5KFElcGETr2IprkHOrSq9Nnew6VwdkDoQeGfGXYgRi
         m0zBtL3hL5HohBvfmXr4eav8c7YOeivAACg4VatmK5gAgaKNtS5xtqCZ6UGLInO9+Jm5
         7ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694468450; x=1695073250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1rskMG9E2Dj5/SRLejxHVPKSzfpoHVWY3HLrjdtxeI=;
        b=IAZ2ZXq3E846aNpc6PwkxArT1OpzPbzQWI00devDm+p2/ROjMS5PcxNVZRm4GsH7Ty
         M2pvNUF2oHEW0jwFDhQogXsdXfN7rVBsxjb5+IbN2dWiEo6P9b9Bvi+ZkrVJ7RhgcxBz
         Oxia4ZAwEBOfKvsWCEH75rHAKOtHTD+rm9b+rZQ97D12aCMsF7VFNa9GGxGAZsR5du4T
         2TTrrkoeupfRvaue8qyEGzMURD8nXDB5m7Wtu5m0TRs52DHP9uCotZISHsD6Ss1iVHqG
         oBeqHtujkbASDRhVL1LgQvklUtL6ewKp/4RsPKOblUc3kx9tP1LU/DE7WKSV+OFKKUSl
         EiKQ==
X-Gm-Message-State: AOJu0YyCROPcx5HLUi/4QUGo4ODefviKIIgFXXfTwqsMbq1Uvir6qUc9
        LmVK295fflu8zuP0UhGIJcLTSbaqxynUUKeaY7REcB+Rtb8=
X-Google-Smtp-Source: AGHT+IEBbzm4jId8t/sqQS9P0cIUPm+VwcG3EInsxExrUNDGMdz+ce4CPwziEBKNo8HiJTPmTfVdkWWgOclzmaCPECY=
X-Received: by 2002:a17:90a:3ec4:b0:26d:414d:a98a with SMTP id
 k62-20020a17090a3ec400b0026d414da98amr9962733pjc.1.1694466242955; Mon, 11 Sep
 2023 14:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230910125726.1243652-1-festevam@gmail.com> <20230910125726.1243652-2-festevam@gmail.com>
 <8ef4aa62-940b-b0b5-60e1-fb42600b776a@linaro.org>
In-Reply-To: <8ef4aa62-940b-b0b5-60e1-fb42600b776a@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Sep 2023 18:03:51 -0300
Message-ID: <CAOMZO5AxQm2s7eNzO+yS5m2sOrwuDKuKwk8q2pt=JJVhO=G3ww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range maxItems
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     shawnguo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On Mon, Sep 11, 2023 at 3:14=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/09/2023 14:57, Fabio Estevam wrote:
> > From: Fabio Estevam <festevam@denx.de>
> >
> > imx93 has a maximum of seven entries for fsl,tmu-range.
> >
>
> Then qoriq should have it constrained to 4 entries.

I just noticed that fsl-lx2160a.dtsi is also has a tmu compatible with
two entries.

Would it be OK to represent it like this?

--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -33,7 +33,8 @@ properties:
     description: |
       The values to be programmed into TTRnCR, as specified by the SoC
       reference manual. The first cell is TTR0CR, the second is TTR1CR, et=
c.
-    maxItems: 4
+    minItems: 2
+    maxItems: 7
