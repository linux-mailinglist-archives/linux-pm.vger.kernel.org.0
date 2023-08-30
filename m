Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17C78DA2F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjH3Sfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243817AbjH3Lrl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 07:47:41 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F1DCD2
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 04:47:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d66f105634eso4888041276.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693396056; x=1694000856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6qY7mr1if4mjzl6N/X/QNgn05V4Hq/iGd+Okpb2gPA=;
        b=dsEnzXEJxuqidSDS1+aIt0UnyaZ+/EWIFdvkiJhxfISwuVGlAcWx3VrTIeZPKeB5LW
         yW5/4H3QF+tl2/s6NcJ8R99D339/D0MhsH9gXKPZ9VuRXV+0QHTQVUxSFGVU7sePaQwZ
         PQ/Fp2NtoM8SsfSlJYqVNwXUWCBwPn9ZEd8+elAXRWJ42cmgd5/n0qhQuB9rYpvL6X1P
         7DXS3vn91YZBZbzxhu+sMfhW3ouH687I7Xr6ql0DYsPOM7svNo6Axdt7o9V+V0qhxFVj
         o8v5qq0SUPVXyNoBG+azlRArycP0T+ArxuqvsWLEmA26t3stwcJpBytTr7PCRd/zqhfw
         4jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693396056; x=1694000856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6qY7mr1if4mjzl6N/X/QNgn05V4Hq/iGd+Okpb2gPA=;
        b=Ja6CrTwCChxnba5XPTlMSMsYexbqZC3BCJ5Xh5H8/YvujfWueeMlBxJrSpaGP21O47
         961D53++uBCy7296mbEM4yW7MB3JCGYYgESlLqErtd5DUFQ2fEQG7+J/TCGbSXhl85UD
         AqqTO3m5CCPsl9C+8XFWeKKTf3mgwQ3f/L66jf4KNQnz7VJG4HwnxCRRktwkPZcjv33K
         ZUG6uuJ4CHC48txCjFTj9odhAM9s0q7J5Vb1DTXpyMfVPfmIOVXTTH/86f8WimXlVxhx
         /y2HlBVACYjIS784oiBLefSaBzEXt5Drc0o31/NYsV8h3qxs4ZLi07rhLs+/Er6lKUme
         /EPA==
X-Gm-Message-State: AOJu0YxAIcu6VL4YWuTgBxuqF9NQ2io0pLhT11FmLUWitVt3boYeLx3E
        FUxMj3arrc644DBTqBTFO+do6FO5infgP91wktHH+Q==
X-Google-Smtp-Source: AGHT+IG+cDfVhvedCJoh1MydyK7VKRA/KVbr4a7x5p2hLIqH/Y7y+yfFDrrjPE8FE1bGRWGIDiLivpaB3dJHFKPBchA=
X-Received: by 2002:a5b:889:0:b0:d32:cd49:2469 with SMTP id
 e9-20020a5b0889000000b00d32cd492469mr2006211ybq.24.1693396056658; Wed, 30 Aug
 2023 04:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com> <20230830-fp5-initial-v1-6-5a954519bbad@fairphone.com>
In-Reply-To: <20230830-fp5-initial-v1-6-5a954519bbad@fairphone.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Aug 2023 13:47:25 +0200
Message-ID: <CACRpkdarpxAS21is7mOeSjqh0_teQcNYf2-WPd5BuLQSjFVF8g@mail.gmail.com>
Subject: Re: [PATCH 06/11] dt-bindings: pinctrl: qcom,sc7280: Allow gpio-reserved-ranges
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 30, 2023 at 11:58=E2=80=AFAM Luca Weiss <luca.weiss@fairphone.c=
om> wrote:

> Allow the gpio-reserved-ranges property on SC7280 TLMM.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume this will be merged with the rest of the patches, poke me
after v6.6-rc1 if you want me to apply it to the pinctrl tree.

Yours,
Linus Walleij
