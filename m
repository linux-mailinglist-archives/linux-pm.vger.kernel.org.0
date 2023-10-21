Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB47D1EBA
	for <lists+linux-pm@lfdr.de>; Sat, 21 Oct 2023 19:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjJURuL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Oct 2023 13:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJURuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Oct 2023 13:50:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83DB121
        for <linux-pm@vger.kernel.org>; Sat, 21 Oct 2023 10:50:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4083f61312eso15379115e9.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Oct 2023 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697910603; x=1698515403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXcLZN8iPsWJ+ohhlVcmVKvXJcBROkJiCLLifqegDq8=;
        b=Jh1dkaavSHj0FEYSVbYZdrf4AZpcrdRBW3FefgoQ16siRULN2xjZtegK2NgYQudqFX
         3s858885568P2wlaLC0zUIYyPDnf2KC62OKyeh6/cEX1NFZnZMCWonVsvat7x0A/2zrL
         ae7j5/lt9p0KV/OrfIFLquAYWnUYrFKNrI2Ww57zGTJlgLq/p4V2iuCoRnYyZoqrUOzA
         ivqYA+4/omW6dWb1jFs92J4WtR/PlUvwNwS1yXM6cb18oWqoOHr6xd90OjCTtj+tKyqR
         dN/mSw7MY+yA0zD62tg+DiJvYfWw+VMjmieaDTXTUBBE96VorUMRLWIYzqB7X2EQhsRq
         nifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697910603; x=1698515403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXcLZN8iPsWJ+ohhlVcmVKvXJcBROkJiCLLifqegDq8=;
        b=c58+UkvZXTXz6YpB6HlCaJry76f9r18/QWCMn2W7/cds+KPt6mOTqh4P2ZfW49ndHf
         8sLmsTA75W89XLoD7kP1cMHKGXG3I/xG6fBHTJK4PRMIWb6RImZ/b8M9zMuC4id19rKB
         uU73MjcquOeQnFnPPsUAdtYpthz2iMIFp79AaN9BQ9xOC8iShnwn07blnYIn49OHOm/z
         FPbNeMjttDM2OL8CcFkziqddguXl1rhCydTQEqNHi8sZ0aXzoO/HEEeEeKu8/vXjodSF
         UkLZbcue2rPgJ8vrNEURb5l1nq3t86nFJWqMJfUPTku2T4Be/3AdfW/6oooKMrdxit6m
         U3aQ==
X-Gm-Message-State: AOJu0Yy6mNSGILkt4Yu7/3eKK7oEaO3HzHG6Gpaj2eJyX3F/5IWHsIf7
        Ck99cv51j6m0PqwUcWQbJ67QPg==
X-Google-Smtp-Source: AGHT+IHkyl2yWkeHcGeoYhzZ55Dt9w0PlfqwiFNT1KJ8m01Tc3KTdgBp3pJhtm9PxofJ0RQ7vRzKxg==
X-Received: by 2002:a05:600c:1987:b0:408:56ea:f061 with SMTP id t7-20020a05600c198700b0040856eaf061mr2003852wmq.24.1697910603274;
        Sat, 21 Oct 2023 10:50:03 -0700 (PDT)
Received: from [10.66.66.3] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id l23-20020a1c7917000000b004063cced50bsm4980526wme.23.2023.10.21.10.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:50:02 -0700 (PDT)
Message-ID: <238b8cae-f1e5-4aad-953e-576460a41ac1@linaro.org>
Date:   Sat, 21 Oct 2023 19:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] pmdomain: qcom: rpmpd: Add QM215 power domains
Content-Language: en-US
To:     =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20231014133823.14088-1-otto.pflueger@abscue.de>
 <20231014133823.14088-4-otto.pflueger@abscue.de>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231014133823.14088-4-otto.pflueger@abscue.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/14/23 15:38, Otto Pflüger wrote:
> QM215 is typically paired with a PM8916 PMIC and uses its SMPA1 and
> LDOA2 regulators in voltage level mode for VDDCX and VDDMX, respectively.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
