Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C640543F281
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhJ1WQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 18:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhJ1WQR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Oct 2021 18:16:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23FCE60E8B;
        Thu, 28 Oct 2021 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635459229;
        bh=FpWvPrRTCuPTrYLKoitbXloNLhE73DIXWeNg6HD/2wc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=evRyyHCg6G5zJzJDSym16CB2l9mf60mr2ehEz/ll5/2/axld4SPDBm3BcwdSwiwSi
         5O0BnAcD1KE30+PD7LINVLB+3c5SMqQLFW9v0CAKvBKbSxifpivTv4ZL33/XXKZ/F0
         qj+3y33Vslq+880QlRgSeeuxFbS4FIN3vMrOjekGirLCYZOtFFTXoPxkZReU4RdM3G
         qZmsVp0UmcFTYsUX/YHVjiIlw19AHuKHf9NkeGqfKhg4USK4dDjgbRY/ievUo/XRb8
         Th1cgIbCdC4D6M7+/B/QjlrcXxQUQMaM+fzeLCBXx8KxNdPrMGBUxcK2o7SNS1gzrH
         XUYM9bZMKUAnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1634812857-10676-3-git-send-email-okukatla@codeaurora.org>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org> <1634812857-10676-3-git-send-email-okukatla@codeaurora.org>
Subject: Re: [v8 2/3] interconnect: qcom: Add EPSS L3 support on SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, okukatla@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        bjorn.andersson@linaro.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Thu, 28 Oct 2021 15:13:47 -0700
Message-ID: <163545922790.15791.7124110557875738156@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Odelu Kukatla (2021-10-21 03:40:56)
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> SC7280 SoCs.
>=20
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
