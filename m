Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFE94DD366
	for <lists+linux-pm@lfdr.de>; Fri, 18 Mar 2022 04:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiCRDDN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Mar 2022 23:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiCRDDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2022 23:03:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FFB1FDFD7
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 20:01:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u10so9968291wra.9
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2022 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=/c0Iug26q6VjeWZuRvSdzvpLlZxwZvT/Nmzo+p+K+ao=;
        b=jQsN0QF/phO+FRlNsyJEGDNHnhHh3E/dp5jXMSMgUobeZlKsk9G1kiced9qp8DHchg
         Uz21WUjDM16ZZGd3RHIkwCywE0RroaFkh2TPNZ0Lg0g6Sjmn/bkpkrKqU1cAuMYlYsJT
         /yojcgZTCUgDiwQw31zDBSDpaX4oVKT+sshLzc4x6AjoIcVJXLbRpwldOHl4DtB0kOCC
         tWVeU8JdBitpDdJnTRHrAio19/KJtfo9E73LiATgc4G+wrIbMPSmRtKIhqjHOhiWfuRU
         clfqrVzvAmr65zDak5u+punBWWtTGqqEbYjkNOxdCaEelQYo4FqsfXn1jAjcaUDKaB4X
         06dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=/c0Iug26q6VjeWZuRvSdzvpLlZxwZvT/Nmzo+p+K+ao=;
        b=60QyJiY1JIVDK+oppU9XJ87yM/0KdFMYRcJBzN+N8bjEWmCwWtkr2u9PETd6938V00
         DfynZ77RnznE+xe2CfxYZ3wJVdvo8JeUZ75GvGpEKYyGBFbmhZOcEHFAWGfgENDFzImq
         bFvyAafcq2IvOFv4B+pvebCe8uHLBa2e/ToFDXWKdAN2Iu3vp5bW69xjzg4uT69oR1T3
         e1jd2SI9EDBPfVPJguXchnZ0hbajQUs+2ZboRxkeqATCWy+6sag6fdgVNfZyuX/lMsgt
         luvbxCPLP1V17n9b1RgPFzCYj9iW9B0epXnQdygyQYqc2pApbDGfd9ufxoj0htgCvH+G
         6sGA==
X-Gm-Message-State: AOAM533rHumLkjDcffvDCRvcvj31r8xfctW6XCZ87xXaXEsOpOnqC4iX
        cqHOLox7Vdlw8jnLPPsrYgg=
X-Google-Smtp-Source: ABdhPJwaoYXQf3q9oNrvpQBjifHESpujqBnzkryRB3fbJ7pkCevUypqbJzO0j0LPAhe/P1Ur5FSVRg==
X-Received: by 2002:adf:f949:0:b0:203:e87d:1d38 with SMTP id q9-20020adff949000000b00203e87d1d38mr5440403wrr.137.1647572513632;
        Thu, 17 Mar 2022 20:01:53 -0700 (PDT)
Received: from DESKTOP-26CLNVD.localdomain ([105.112.33.76])
        by smtp.gmail.com with ESMTPSA id c2-20020a056000184200b002037b40de23sm5338186wri.8.2022.03.17.20.01.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2022 20:01:53 -0700 (PDT)
Message-ID: <6233f621.1c69fb81.d0320.530a@mx.google.com>
From:   Barbara Finance Company <paulyoropuu@gmail.com>
X-Google-Original-From: Barbara Finance Company <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Schnelles Kreditangebot
To:     Recipients <info@gmail.com>
Date:   Thu, 17 Mar 2022 20:01:38 -0700
Reply-To: barbarafinancecompany@gmail.com
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hallo

Ben=F6tigen Sie dringend einen Kredit?? Wir sind ein zuverl=E4ssiger, vertr=
auensw=FCrdiger Kreditgeber. Wir verleihen Unternehmen und Privatpersonen K=
redite zu einem niedrigen und erschwinglichen Zinssatz von 3 %. Antworten S=
ie uns unten mit Details, wenn Sie interessiert sind. Vollst=E4ndiger Name,=
 ben=F6tigter Kreditbetrag, Kreditdauer, Land, Telefonnummer, kontaktieren =
Sie uns jetzt unter: barbarafinancecompany@gmail.com
