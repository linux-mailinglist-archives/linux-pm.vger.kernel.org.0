Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C66310317
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 04:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBEDET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 22:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhBEDES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 22:04:18 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C7C061786
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 19:03:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f14so9302588ejc.8
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 19:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HdD5j9j3cDfjeYVvH0pZjtrZ1PN33V1eaKUOEOiYAwA=;
        b=MCMgQ3BYFsf9mhagcx4mgzpXPagKjbvtJ0+E0wsfHfLu/UZ/cI1ftqJOZnqmhhBf79
         0YZ2LAxqGE8ftu53EGD3mVgkOQprDB591lZYinaLo4uPXB7e1Ebby2muI7HoP0T7zSQr
         G6vIvNdyz41RhUUpBXVLJX+sZCkKTLvHJ0BuwjGmJEwxw5PmvrBTVt2H57GEUZIS9Upx
         gaZA8u5FVEeck1Esp5wRI3RND1hFJA69Fw1Cy6x9g7A3v69vddDJYUtF/uSD7V4P4pjX
         IuSPk6h6og6kpLQN4o+YMhTMI4u5aUIXFzhj0GHUMq328asHle5Ne2gNpFUFUOYPBLc7
         o5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HdD5j9j3cDfjeYVvH0pZjtrZ1PN33V1eaKUOEOiYAwA=;
        b=hQcbXD03gY1FQUfcmxsBbmkBVpUS/iS/dWgFi+Pr3WcAIdGvwpE+K/A8xsJZU/yNXN
         ocsoZKDNetGbbTrR0lpQd2i4CccUOQKCN62VHuY2GJYroOccXtrqyKqZBdVTOdkdy3Cz
         BqzsK06GuT6gWGvcI0fUa3NukCIE0s1wNNpMOoc6yg7swlGL5hY64kCEnzWlR4PGeGqo
         KZm9qb7hzpiBLwa8G+dK7/Mu0I2S89P1PtlDv/fuyHSGXDOLowV2H508cLB+U1aUnlpz
         ghABk+7NwJv3/RfRzYzUBCFPHx646RsLtuCs6yeHm5OqnyQgkgcq3BhrGhBRzciTjW+r
         B5IQ==
X-Gm-Message-State: AOAM532UFR8G7V1NqPtkwKEcO5tgJRBuyOJ7U06YtZPcavZPaseKafsg
        WOUOeXQnq8k4uN8592DEWtlEocc+/ExU3SKFjRNzAA==
X-Google-Smtp-Source: ABdhPJw0PU39HJiajGWKqQ+imH+UHqp7b05QK93dctO7TbXzblEzR/b6gXLoEwUEYGmAkDwAg94gyHIUfp5CyvY9OCk=
X-Received: by 2002:a17:906:5846:: with SMTP id h6mr1992980ejs.521.1612494217144;
 Thu, 04 Feb 2021 19:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20210205015205.22947-1-benl@squareup.com>
In-Reply-To: <20210205015205.22947-1-benl@squareup.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Fri, 5 Feb 2021 11:03:26 +0800
Message-ID: <CABymUCNfCZT5bkCeHOf6SEw1aStCNcXraen5pEiKSpcXc16z2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Clean up MSM8939 interconnect driver
To:     Benjamin Li <benl@squareup.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, kernel@squareup.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Benjamin Li <benl@squareup.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=885=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Following up on a review comment on commit 6c6fe5d3dc5e ("interconnect: q=
com:
> Add MSM8939 interconnect provider driver") to clean up some log pollution=
.
>
> This is based on icc-next (which appears to contain a refactor commonizin=
g
> functions into icc-rpm.c).
>
> v2:
> - Update commit message to add a full explanation, rather than referencin=
g a
>   previous commit.
>
> Benjamin Li (2):
>   interconnect: qcom: icc-rpm: record slave RPM id in error log
>   interconnect: qcom: msm8939: remove rpm-ids from non-RPM nodes
>
>  drivers/interconnect/qcom/icc-rpm.c |  4 ++--
>  drivers/interconnect/qcom/msm8939.c | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> --
> 2.17.1
>

For 2 patches:
Reviewed-by: Jun Nie <jun.nie@linaro.org>
