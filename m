Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A377717310F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 07:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgB1Gcy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 01:32:54 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:44338 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgB1Gcv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 01:32:51 -0500
Received: by mail-pl1-f181.google.com with SMTP id d9so838489plo.11
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 22:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dtcRx/xrQcP0C0zv1gSyxKTgfZjSQZqO9VhWjTr/Rf8=;
        b=fctCtUQXeEJuPvJTvnsSzRpmaM69ybDBogj8K0in5rgbuquVAaguD7FvrQdIoJQ18d
         gh5r3RY8/kRzkPcP0ILXzEC7n0X9FnHwrWynuI1FChMQtzZkU4mDjdoRY8YsCIXBr5QC
         4lsX+vmTpX2j7cTQJZCT6shFP1sb1CEYZf/hgqskdiGhq+LEfpTLywFZfhXSAQG0bHoT
         eMs5fDaoqke19VeezsAb0N6zzye0sR4hTxDUpcEtU82x3j2NzK8OCUECmJQPoEf4nafi
         qjS1JC682spxFN3dQQT0xw7RRq2WfX05SLrtnaR6TxyVaGYV1oyV/yiIKfl7uoUa5yF9
         a08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dtcRx/xrQcP0C0zv1gSyxKTgfZjSQZqO9VhWjTr/Rf8=;
        b=kzjZwVBUE3h4LqJVzNLA/X3zWQP1qWpUesK6dqvcVPiVkIPK6J9Z1A6vhk2/9w35bA
         UhGdSuKW74/uuib4cD4jvxiPJRDseXsg9dSqQNH+AqDyo0JSqTNcqpPHuPo+OrgiLalI
         DEos1pXQi+Jglbdh1VYsxpOryyHNOU7oc9YAed1jAPGOQhB8L4JYvectgc8xli69I3IZ
         KBiSP+AEcgQ1+vO/2G2q7pbPt1m4OpW+wsZ7iSX8WsSfUgJK5fdI04KtH5wwU9Zhq/vk
         CelaUZmePzkebxSUJdfBiQE2DeoNXVLZq5IMMenUlOKdAK7zTSF22LDdAfsBVlQm1Nt4
         /eAg==
X-Gm-Message-State: APjAAAXfV2cwSvQ8VJKGcpW85LTA/KfygYxJuFDlGbSQz3ndT9jMSynV
        jb4ThA3iMNCF+suMgSnp8rQD0A==
X-Google-Smtp-Source: APXvYqz9kjSDoKMHEw4EyvHBEIxPfo4zgvKkRo5JXyyFZ8yKQKx+Rc+7EnCJ4hfYEadj0CglZKMFsw==
X-Received: by 2002:a17:902:a408:: with SMTP id p8mr2724487plq.132.1582871570204;
        Thu, 27 Feb 2020 22:32:50 -0800 (PST)
Received: from localhost ([103.249.89.56])
        by smtp.gmail.com with ESMTPSA id x7sm5555746pgp.0.2020.02.27.22.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:32:48 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 0/3] Cleanup dtbs_check warnings for tsens
Date:   Fri, 28 Feb 2020 12:02:39 +0530
Message-Id: <cover.1582871139.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make dtbs_check pass for tsens bits. I'm working on another series to
cleanup other DT warnings for QC platforms.

Changes since v3:
- Fixed up subject prefix
- Added acks.

Amit Kucheria (3):
  dt-bindings: thermal: tsens: Add entry for sc7180 tsens to binding
  arm64: dts: qcom: msm8916:: Add qcom,tsens-v0_1 to msm8916.dtsi
    compatible
  arm64: dts: qcom: msm8996:: Add qcom,tsens-v2 to msm8996.dtsi
    compatible

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi                     | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

