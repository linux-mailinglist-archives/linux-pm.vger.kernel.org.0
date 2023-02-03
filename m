Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2707688E6B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 05:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjBCEHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 23:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjBCEHD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 23:07:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F9E84B7C
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 20:07:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y19so4065362ljq.7
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 20:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdXrl6jFXUFLX/Fs8Y8vVeX1SCyz5eISp65do85FsLM=;
        b=giRO/0Lr8QjY/NuoJqnrqZWr0LmwzOD3jmpWfjm5JbisDUMhfSppPvF2poel/JwAng
         z4I+JYUG7niuOyibxKh4v/3DLvyOThvU/qNORVgp+KVuoz54UqGmtwi7Phws3zAMdMLT
         2wtKpfMfkLkWzEntG6phV1GBOsNd1jIgusi5Q9a4MXoBpD5I/ivxHpW0RFF0tZBcadWU
         5yAfyHKkkwfKmtyGy3xvsOivT7CzvDAxKI6UujeqXBQNYK4w5nf92OBQGRxUwJuQW47o
         vuQb8gkyWXKJ9ThQKaYAH2nv/31pRGdD1fz3VyK0Py5zaedLNB6D0HYgVCkxL2LMTXat
         FYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdXrl6jFXUFLX/Fs8Y8vVeX1SCyz5eISp65do85FsLM=;
        b=fJuQK31Zxxy12iljHNT0JrjV1BY/p/MVe9ZITYJkUfBQq7JSA05KsjG0yDtFsAyWLR
         RchqNTx/L1HVxy715cmuKmKB5/x7cPyIfwmtNkRK0cmnMPDHM1gpXonb+YQYMi4bHTap
         R5StWi+3DjK4u/xOLZODrjIABiCXmVXsDNUzFQHGJEJfKTIJYPMJdvvZfPvfyurUaZpG
         8ZNVtk9OoY//HizCF3/7YVzYpsrQH0t44P+azS7WiIToXuGCmsNe2P3MNHBgQVvg368l
         bbPBiIlmUIbmFVqa7dY5Nj9u9gs3yD87Kxe8gCOZG9+N4bsPOBFJLZ6jyyYteKug6gxw
         9n/g==
X-Gm-Message-State: AO0yUKVRXsRT5KZD66EyocEGrVfgHnIdSF9vXiyKeWcPo3Ua6QAKWWCw
        +wxup1pqO1rygHe4qSl3lCEaI56FhcuUeFIQRrBD2w==
X-Google-Smtp-Source: AK7set8ePtCHM1Iq3qNLDJDujeHBggdkNrTSmEo6kURlW1fNmHwpxqtfcCcjPvkRToDgjzFMlniM4/dhmf794eZbSl0=
X-Received: by 2002:a2e:a4c3:0:b0:28e:92b2:a04a with SMTP id
 p3-20020a2ea4c3000000b0028e92b2a04amr1366705ljm.34.1675397219676; Thu, 02 Feb
 2023 20:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20230201101559.15529-1-johan+linaro@kernel.org> <20230201101559.15529-9-johan+linaro@kernel.org>
In-Reply-To: <20230201101559.15529-9-johan+linaro@kernel.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Fri, 3 Feb 2023 12:06:57 +0800
Message-ID: <CABymUCMgmyLRGo+b4ZiVJacxc=hnfo7iiYBNj2i5UPrq3XL0nQ@mail.gmail.com>
Subject: Re: [PATCH 08/23] interconnect: qcom: rpm: fix registration race
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Georgi Djakov <georgi.djakov@linaro.org>
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

Johan Hovold <johan+linaro@kernel.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=B8=89 18:16=E5=86=99=E9=81=93=EF=BC=9A
>
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
>
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.
>
> Fixes: 62feb14ee8a3 ("interconnect: qcom: Consolidate interconnect RPM su=
pport")
> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provid=
er driver")
> Cc: stable@vger.kernel.org      # 5.7
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Georgi Djakov <georgi.djakov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
