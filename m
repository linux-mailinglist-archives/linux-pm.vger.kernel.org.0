Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D523DBCB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgHFQcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgHFQcF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:32:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2D8C0086A9
        for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2020 09:31:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k20so10268642wmi.5
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2020 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EjdHovA6pZhCGDIxpXlqTI6MPX2VaDhsI56ZjDVyws=;
        b=srEzXbtVUdgu44HdzXkXf2AxcnIqodA/urxiuekKMnDaoiGV2acenxFr53rvkguLUf
         dpASK/e72i8vVBbrtPa6ilthaekLyW9TgiLQxLjx0zIiNBiyzL5inBgxCzp/tHG2/keR
         2Uj+FjF0ybIbPmYi55Sj/c3uFKzn6YSRiTOyNdCs8V8mwutMqzsWnpghadwHvsAH9E+G
         HySprz3wc+JOVzTCPowsQaHape+e7GYavYYmHFGcRJJQghf4/VeIe7Rwe7H1ZlE6g/hb
         +qf8FnvXGSiZ7OpV351VShW4oZcGHB6q2RLhQYzEnHBy7fOg0CvurHy0MbgHtjMShV67
         3ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8EjdHovA6pZhCGDIxpXlqTI6MPX2VaDhsI56ZjDVyws=;
        b=SsM1pgKA6cRNjrs0ALxN63ehLfYk9E3gh5GM/lKgjT1z6A5Uh1YcYT+bBKpWF5kzR8
         2jOQ9SM3JwRB3uMoO8VzmRBeF3IJG4OaNmdtQUxCWyYc7naWc3/c3f4SGyA3YCipBCw6
         M0gmDTJKBCDv5kdb5Ooy20hCeFp9+3+BMnzGfdcVEaVUJnZFUOQWp0Tp/VGGpfmVm555
         UpXO4EjDJbp8tzOPS+Dr3jLQaWqz89s/zGd64FfSUidtcp2qx6P+TWwagrk8+EQXIlFn
         jitPL/D4iNFPOe2bi5RHbrnxFpPRsDbmIXhtYBJgiqf7BmA0lKoH3I23eajSOnS+y9lQ
         01uw==
X-Gm-Message-State: AOAM531P/lmbVDMN1y7q7ffX7f+2HZeKKLFw18tDBNGIgzxp4gYvbUG/
        VHpcbklVS5DfPdgN5HF+dFGOB5/5CBk=
X-Google-Smtp-Source: ABdhPJypiYwGRpysEd1neDA1eIk52zMbC2H9K1CR8BaJUNaCtbcDui/TRhD4tJ0nfK9bVv3n+mzotQ==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr9046794wmj.111.1596731488952;
        Thu, 06 Aug 2020 09:31:28 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id i66sm7468537wma.35.2020.08.06.09.31.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:31:27 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        sibis@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] interconnect: Introduce xlate_extended()
Date:   Thu,  6 Aug 2020 19:31:19 +0300
Message-Id: <20200806163126.22667-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the interconnect framework provides the xlate() callback for
mapping the endpoints from phandle arguments in DT. This is implemented
by the provider drivers. But the endpoints (or the path between the
endpoints) might have an additional attributes, which should be parsed
and populated. During previous discussions [1], it was suggested that
adding more and more DT properties will not scale very well. So instead
of adding DT properties, such data should be put into the 'interconnects'
arguments.

This patchset is introducing a new xlate_extended() callback, which
would allow the interconnect provider drivers to parse additional data
(such as path tags) and allow the framework to make use of them.

Thanks to Sibi for the preliminary feedback and testing this patchset
on the sc7180 platform.

The patchset is based on linux-next (next-20200723).

Changelog:
v2:
* Add a patch to update the DT documentation, which i missed initially.
* Minor changes in commit text of patch 1/7. (Sibi)
* Remove a useless null check in patch 4/7. (Sibi)
* Print a warning if the number of DT args is higher than what we expect
  in patch 3/7. (Matthias)
* Pick Reviewed-by/Tested-by tags.
* TODO: Replace tag IDs with macros in patches 5/7 and 7/7 when [2] lands.

v1: http://lore.kernel.org/r/20200723130942.28491-1-georgi.djakov@linaro.org

[1] https://lore.kernel.org/linux-devicetree/20200519185836.GA469006@bogus/
[2] https://lore.kernel.org/r/20200801033215.1440-2-mdtipton@codeaurora.org

Georgi Djakov (5):
  interconnect: Introduce xlate_extended() callback
  dt-bindings: interconnect: Document the support of optional path tag
  interconnect: qcom: Implement xlate_extended() to parse tags
  interconnect: qcom: sdm845: Replace xlate with xlate_extended
  arm64: dts: qcom: sdm845: Increase the number of interconnect cells

Sibi Sankar (2):
  interconnect: qcom: sc7180: Replace xlate with xlate_extended
  arm64: dts: qcom: sc7180: Increase the number of interconnect cells

 .../bindings/interconnect/interconnect.txt    |  24 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 216 +++++++++---------
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  44 ++--
 drivers/interconnect/core.c                   |  73 ++++--
 drivers/interconnect/qcom/icc-rpmh.c          |  27 +++
 drivers/interconnect/qcom/icc-rpmh.h          |   1 +
 drivers/interconnect/qcom/sc7180.c            |   2 +-
 drivers/interconnect/qcom/sdm845.c            |   2 +-
 include/linux/interconnect-provider.h         |  17 +-
 9 files changed, 248 insertions(+), 158 deletions(-)

