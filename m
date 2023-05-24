Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9170EA48
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 02:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjEXAel (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjEXAek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 20:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFEAC2;
        Tue, 23 May 2023 17:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C8D61536;
        Wed, 24 May 2023 00:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 128A1C433EF;
        Wed, 24 May 2023 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684888478;
        bh=grr9x/N/VP19B6Af/fwQVdP70KTtMERFQJVJQj+7M+8=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=UHEJF+9Eb7Z5SmXQCrUgahxY0JDCkg0L7211diC5i7omECQiC84jEH7Ebn4+6bbOT
         LHh+cVMekkF098zAeWJRn3K+iDyLmLrBzWmboCAooron2jnEUd1wzv36PcoJH4vAvm
         moz/ni9RpKWIKV+1VZLcgdPZBk0B6aX2WYekM8HFJWQbDaf8mMYWtrAv4uy1CUojvL
         tj74AsVVL6VQXTr7vti+pSbZvX4yAEN7fDtOevRQzRKaSpUoi+tqKarQ+BG35CDCLq
         ZFCHNfQt71Gq0PbRH+bZxtbM5aZSj9U80rtXzEN7130xIbElzv9g+gmydchKei1CCP
         0z1VeRIjye1Dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id F02A2C77B7E;
        Wed, 24 May 2023 00:34:37 +0000 (UTC)
From:   Caleb Connolly via B4 Relay 
        <devnull+caleb.connolly.linaro.org@kernel.org>
Subject: [PATCH v8 0/2] power: supply: introduce support for the Qualcomm
 smb2 charger
Date:   Wed, 24 May 2023 01:34:16 +0100
Message-Id: <20230524-pmi8998-charger-v8-0-b87ffcd9864d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIhbbWQC/x2NQQqDMBBFryKz7rQhRjvpVUoXiRl1FqYyASmId
 zd2+Xj/8XcorMIFXs0OypsU+eYKdGtgmEOeGCVVBmtsazrrcF2EvCesVidWJGt8inF89o6gVjE
 UxqghD/PVlbSQ6x793WHi7RqsyqP8/pfvz3Gcd6ajroIAAAA=
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
X-Mailer: b4 0.13-dev-1ec66
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=grr9x/N/VP19B6Af/fwQVdP70KTtMERFQJVJQj+7M+8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBkbVucI7lxOiqYKTm8CTAStsuPKFmnMs5YDsYN2
 FCaZZ6pnDqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZG1bnAAKCRAFgzErGV9k
 tlt0D/4vqoWHEdygCZEXrnaFrUn9i8Isyqol2BP6/1tk6bqtYUisiD66UAhPsfg8JkpDXo/77YH
 5DHmG2vOtME1oIdDjGX1ejBLmI3eS7cbkIexEn0HyHwUbZimxiXy4vT4J+TX1Of+GJNMIJeDtSQ
 ydhsr29WFxPZDWsSvSjAB92H9ytAO8wjK0ing5/GRFmPe9dzAZoowZJBcm1N8OzDSJwqBj97Llf
 C5YXDIYXwQhbcvdPQsC8q2OUZ7HWdQ56toZ24rNheaiwFi6T06peDRNnKGAXpYZJspz37eoKOIm
 VXoOGZX1ljAnwolLH64y+Uv9Fj0mVVCXwTuOiEe6u65oBpWA+VziruGNAW9dhtA5F/IJNr7HU/K
 W9cKBtFSCENUDcCzUHeRDFYm7Fb4/REp85onez8mTUZ6C3H/ziwwI5AA4Bgtv8zDOc+xwt29ZBa
 w7UlzOIH/kioHG9QCowL1WS5P1eqx1m//yn/aTfruYSQN+z/iK18JXTFWRbRojaTdZICM0bt9q+
 RKvFqg5Bw28ziIennihC3JUgp6BPBVXyGYl3HhGEOIAB/sokaC6rvtGNLMQn6LsNjlH5da058LA
 ZMoU6iwwZ3cQujRtIs7VuY8y1uNCc1rK47FehW31iqLZN1Fqb8XzRrIXw3CcuKR+tv6g0hoN4Fd
 TXrcClheTEGkNDg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Endpoint-Received: by B4 Relay for caleb.connolly@linaro.org/default with auth_id=49
X-Original-From: Caleb Connolly <caleb.connolly@linaro.org>
Reply-To: <caleb.connolly@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
This is the second generation SMB charger, and replaces the previous
SMBB hardware found in older PMICs.

Changes since v7:
 * Implement fixes suggested by Sebastian
 * Fix format warning
V7: https://lore.kernel.org/linux-arm-msm/20230127230506.3140297-1-caleb.connolly@linaro.org/

To: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
To: Tom Rix <trix@redhat.com>

---
Caleb Connolly (2):
      dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for smb2 driver
      power: supply: add Qualcomm PMI8998 SMB2 Charger driver

 .../power/supply/qcom,pmi8998-charger.yaml         |   82 ++
 drivers/power/supply/Kconfig                       |    9 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c        | 1059 ++++++++++++++++++++
 4 files changed, 1151 insertions(+)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230524-pmi8998-charger-8209dbbf7648

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

