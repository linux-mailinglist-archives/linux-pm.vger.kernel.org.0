Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37EE43F278
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 00:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJ1WPo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 18:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhJ1WPn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 18:15:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3729060E8B;
        Thu, 28 Oct 2021 22:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635459196;
        bh=2zE2wrHzuqiWObO7CRKjG8u0vDoJsalCVCWWAt5ZCTQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fUq4WbGvI2rgkFX5oHFu5fxoWAYODAENC5Tu4zh98VmDSZ2I1yvAK4CFOVbi09oWO
         semIU2WchnL8rbff+BUcMUN20Sm8HMaojs2gB4JW1CcCsuB+z2GmhCLsQM+N9AF/I3
         WWRPnBEpEXJdNYaTZCp9xwwT+UloYAw4SSfC71FQgplQeyGsyoGWiwBmaIiLz7LnsU
         iXaza0VSeUsA4b9ANbkFY5a0+trs+tvIXwQsTIvSdx3ZG1KqOpnFVJZwRgw6/XBAg0
         t/ivSDvzotQ4UrC7cXDElSCaCLSjixJ5/y1z1AbZbJAlKR2PJBvcEkLhH+16hHtJ/t
         Qde9Vht0U0vFg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634812857-10676-2-git-send-email-okukatla@codeaurora.org>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org> <1634812857-10676-2-git-send-email-okukatla@codeaurora.org>
Subject: Re: [v8 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mdtipton@codeaurora.org, saravanak@google.com,
        okukatla@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Thu, 28 Oct 2021 15:13:14 -0700
Message-ID: <163545919495.15791.17514925194518124657@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Odelu Kukatla (2021-10-21 03:40:55)
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
>=20
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
