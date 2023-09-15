Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950FD7A26F1
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbjIOTJW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 15:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbjIOTJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 15:09:13 -0400
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA1AB2
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=1EAJ4MyB4CeKf3y8luo3OHGuNGZuBUJF9X05j2FuvO8=;
        t=1694804949;x=1694894949; 
        b=q1VAj6G4H6ZX4fkiLclIezU2ikD3Km6KMoSGUWW43T/Wu5x/rStHebkViyBdI053d3SoNFDLxoJCnmqeywXBp4ytGJtw9HDfJ8fmgAL8UrMcken4wsqJ/mUef4QjXMOIjGnJe1n8zGxoSiVBAWGOUlHUXbObVgCJBej3jaQU27w=;
Received: from [10.12.4.13] (port=55446 helo=smtp38.i.mail.ru)
        by fallback3.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1qhDRH-008PVw-UD
        for linux-pm@vger.kernel.org; Fri, 15 Sep 2023 21:21:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=1EAJ4MyB4CeKf3y8luo3OHGuNGZuBUJF9X05j2FuvO8=; t=1694802071; x=1694892071; 
        b=fPu2rRhg7Nq/YVcElo6IjfYd1wVhX5QE5oX2FNWHHXErTsQlZe2kSX1ZQU2RBSpVBWiro4HD2Df
        k8ygKE/fGbYuR8dqv+6D/F9vVf9LVsr8OgpTWXgVY6QlS4r3YZJ3aHbWWzJxIPxDwF0SsYs9yy/FP
        NGy3jRhVfJhFY4IAu00=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qhDR2-00G5R8-2S; Fri, 15 Sep 2023 21:20:57 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] pmdomain: qcom: rpmhpd: Add support for SM7150
Date:   Fri, 15 Sep 2023 21:20:52 +0300
Message-ID: <20230915182054.113839-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9FD052C19707CBA10F74D70DBBC233CD7A016A66332CED23000894C459B0CD1B9FE37D788047F10F26D2A3C4C71BE5BF8F642992ABAB832B1EC10A369B9726780
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE725E3293E3D307E31EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637BC4B0F5721B555078638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FA62DAD2221BD1DB0F3D7126E3F97DF6117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF80095D1E57F4578A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD18BDFBBEFFF4125B51D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA9287C8E22D4AE2A51D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3A6C7FFFE744CA7FB302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407978DA827A17800CE773BC869C69ECC1572DBA43225CD8A89F616AD31D0D18CD5CCE5475246E174218B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5AA9F61933AFD9F396981EF852F3FB576B53BF95D14A621FAF87CCE6106E1FC07E67D4AC08A07B9B0724336BCC0EE1BA89C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF873FF68E64D474DE0DFE621E33E39D7DCC8669BCF65459E6D214B1B580AAEEE3A7F6D8DEE3A50DD4B3573C328C294A3D78C1FA6C71D3302835C65DC30ECE73B421BEC6C0C71ED4F84C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXgvKRERB/FFM2dzbXG/8aX5
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812E816679BFB18EEA50023357CE020C003120E6DF4C99E2C9643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B44C707F29C0362ABF9EEA92AF22DBF0931036D7FA51828D15049FFFDB7839CE9E5434182FDB816D04266C1BBCA6381244D867F0B104D42B85FAE5F190D37F12B6
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdaloFI76w+pK+PrK8jl8HrA==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds RPMH support for Qualcomm SM7150 SoC.

Danila Tikhonov (2):
  dt-bindings: power: qcom,rpmpd: Add SM7150
  pmdomain: qcom: rpmhpd: Add support for SM7150 rpmh clocks

 .../devicetree/bindings/power/qcom,rpmpd.yaml  |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                 | 18 ++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h         | 10 ++++++++++
 3 files changed, 29 insertions(+)

-- 
2.41.0

