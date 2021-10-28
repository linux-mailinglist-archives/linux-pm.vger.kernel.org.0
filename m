Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78A43F286
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 00:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhJ1WQw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 18:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhJ1WQt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 18:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2130060F21;
        Thu, 28 Oct 2021 22:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635459262;
        bh=onadzWfgLPpUpBKJ+JVyWY31TdkFRWw0WyEa4lKUYHo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ChNm3uj0va7YpJ+4sXPHWIpStZL+YY/LMoo0++38qFkpMlSHlaQbeWPdURsgKcbyM
         kEGA6oXlIJH2a5M+zbW276pSfCZMgn7/wxU28HJ0LIe5NL1SKRtTvoK4jm9r+gUaEn
         FhShOvaSRuvOY2x9yb4cXTiZhwbyF0CEhPyDRn0IAdkzHrR7Zmr7754tQex7h1H8yT
         G2srvfWcCJdGJq3HeUaHs6QVTG1nbK3SRvlYD6t8yQGfgND0qROImMxs50zEQVuQ4M
         ub6A2sQ1rIKMH7vCFag7gdbH5d3Gm0F8M5wa2KpeIys9dZPJ4x3zlCH0TWP1v3olkL
         npRhVja4/7y5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org> <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
Subject: Re: [v8 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, okukatla@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Oct 2021 15:14:20 -0700
Message-ID: <163545926092.15791.695600896724921402@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Odelu Kukatla (2021-10-21 03:40:57)
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
> SoCs.
>=20
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
