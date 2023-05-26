Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363C771252E
	for <lists+linux-pm@lfdr.de>; Fri, 26 May 2023 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjEZLCO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 May 2023 07:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEZLCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2023 07:02:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B70F7
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 04:02:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96fab30d1e1so154224366b.0
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685098930; x=1687690930;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+f0WP/+N5MvUYe92/BSqybSsARXcqQ8M6AlwJr5eQc=;
        b=H6fIMacSOlzEPfx+iMCwiuj6mly3+6RDfRmotkgkt1Id1FbUk1BtBt5ivIrb7VWfSt
         AEafpZ/8kYH2+JzX9JIXNsWQSg+cp2IlBukwlX6BNbS5VmBUR9NF56relSwhgdDfpsjr
         KjMWoFC7pT192Q2sEiy2Ox/zwdwk9pmthp/vTJ9UFXoGUhsoay6eHa2O+iFSjEIcG0FU
         YQxTBOOsFjmZrz43edCJY2Q6pxWpQsYOXtr88TtUD1SFbAY9EbKDLTKIc+twL34xg1w2
         DEyHwT5uHVA+VF0ngafLiqFSXbAzlgACG2wjx9aR2ltKnRRMJIijScrB+/XHtcaj9F1c
         5xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685098930; x=1687690930;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+f0WP/+N5MvUYe92/BSqybSsARXcqQ8M6AlwJr5eQc=;
        b=NWTd6ziwhSPoZ+RKfRHAEi6IUc8MOx4h9No6nBCfScs1g87eBWMDKVWvGUTmH+tRVD
         AiM5JH+zym47863ejThpefsL925sZHsDzDyEqWHiKbLdv4lFbTPjvYzTL5fcrG+tp3Iu
         BkFnVmdyB9M/RGa3M+JU5TtfmkDrSSkDV/MHLrZSYHUWmOORO9HAdS1103N1ABd98rpQ
         QlErJenLSDtSYwxFKKcq1xQtL30cyL67p6dXmXFeImitmvGLbPTEklFQX9CIqNF1E+F/
         u3V/2ZCFpYkXk3BwBCFnkFuSjQ9px6kYzeyvdK0AKCYMhegh7z4sIKsIS6komX8bzVJ2
         ZFOQ==
X-Gm-Message-State: AC+VfDzmk+ppS4pTTt3zlrqT1Fhwein1k5US3sJaKI22tZf+v+EM2bcj
        3aIkXMlNFhlxpPUZl06YVZ82d6apkozSkvMP6gw=
X-Google-Smtp-Source: ACHHUZ4JnnZcNjsIG8BfSqBxYNaLhqxUtjbmBXPq0DowyNX3MT0iL4h8+FSBPjg5D+fuTM4kDBS4k19SMGKCRr5U+K0=
X-Received: by 2002:a17:907:3e9c:b0:966:1bf2:2af5 with SMTP id
 hs28-20020a1709073e9c00b009661bf22af5mr3846372ejc.22.1685098929822; Fri, 26
 May 2023 04:02:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a872:0:b0:215:8936:d3be with HTTP; Fri, 26 May 2023
 04:02:09 -0700 (PDT)
Reply-To: laurabr8@outlook.com
From:   Laura Brown <jeswa7m@gmail.com>
Date:   Fri, 26 May 2023 11:02:09 +0000
Message-ID: <CACGCBD4xf54Ng8uuXyZei91pc8aJ2=pSWfrGKtZBs=OfGQTEqw@mail.gmail.com>
Subject: =?UTF-8?B?15nXldedINeY15XXkQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15nXldedINeY15XXkQ0KDQrXkNeg15kg15zXldeo15Qg15HXqNeQ15XXnywg15nXpteo16rXmSDX
kNeZ16rXmiDXp9ep16gg15HXoNeV15LXoiDXnNei15nXlteR15XXnyDXlNen16jXnyDXlNee16DX
ldeXINep15wg15Mi16gg15HXqNeQ15XXnw0K16nXnCA4LjUg157Xmdec15nXldefINeT15XXnNeo
INep15nXldeX15bXqCDXnNeX16nXkdeV16DXmi4g15nXqteo15Qg157XlteQ16osINeR16LXoden
15Qg15bXlSDXkNeg15kg16jXldem15Qg16nXqtep15nXkdeVDQrXkdeh15XXk9eZ15XXqi4NCg0K
15zXldeo15Qg15HXqNeQ15XXnw0K
