Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBF534E3B8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhC3I7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhC3I66 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 04:58:58 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F72C061762
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 01:58:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h3so11683140pfr.12
        for <linux-pm@vger.kernel.org>; Tue, 30 Mar 2021 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:reply-to:accept-language:content-language
         :user-agent:content-id:content-transfer-encoding:mime-version;
        bh=+uhFrBWaCsyuNOo4z1kocdKrE8L+h5QcfAeQ5IrnGB0=;
        b=hpW6OY4VTSdGIxYQpyhMwxyfpp8NCBLUGaRQFyVhvX8/y5x7xpLA223FcxVyiTjRkU
         NJZQZtnH8fJ00zR7zqv2IF9kbId/eybJocOs7kdIg/FLaBs3XNxdUTKYIeKzHEYLtgHA
         TJHESMwzDwkic5tdYJ4S/UEZ1Gqe5O9VOiRHYADptVT3iQ0NthEePzWI9MfVUfFfpoq5
         Go/BUFAXpViw9W2ydVunAkj7XhcyMEztXcaVH1YjbuLafpnrxde0eeNwvrsSJQzw3wsX
         zZ/3MQ27kzIxiUPPUDiqO0ANJaKEomcg8okHzxZ+lHgxwaf5jcAGhjSfBOZ6I6bhgi5e
         G2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:reply-to:accept-language
         :content-language:user-agent:content-id:content-transfer-encoding
         :mime-version;
        bh=+uhFrBWaCsyuNOo4z1kocdKrE8L+h5QcfAeQ5IrnGB0=;
        b=M5EOD5duvt1LDZCvdxhcj8KegUZf9xm9bRUPhoEN9qKB9QSErX2Z7nrzeQyg5GkYJG
         tR35A+c/tv8+sFgvbwLseDuZR2B9agPUUKkkjVbevPukS1vdLSy0Mv/i6CAhnkC6eYvu
         kghGakJSxN+XMaLBAx6EQttJazAnXDzlmIoSs/JB647siHabcJzTeGuoJ2TJAwW8s1ai
         iJIreWzWXcNQr6xoneJF5v/BRRkMhoQg6UUP1pzznvADzjYOmrns0qIF8N3uoZPJcelJ
         L6v/7iSTBVbIbrnFtycxJnqSETE4UBUSC9nsgaDUReYEUdH2QnneIM7tHSaxlVbcdgqy
         nXRQ==
X-Gm-Message-State: AOAM530wPDEVhsUKH2/JylC2FON5wkJWzfRN+abrjLI5Zhjq03v5k4ZH
        sNgXndNmhjOUkgX0MSA9rPkrPQ==
X-Google-Smtp-Source: ABdhPJz7LwupF/B1gNSoRnCm8bwQgn9zwOYz4Y9wzg7e28NAKTcbiMTJxnxPfMLrTybbYLom2aBD2A==
X-Received: by 2002:a63:c90c:: with SMTP id o12mr28187503pgg.210.1617094737576;
        Tue, 30 Mar 2021 01:58:57 -0700 (PDT)
Received: from PH0PR06MB7560.namprd06.prod.outlook.com ([2603:1036:30c:50::5])
        by smtp.gmail.com with ESMTPSA id h68sm19401653pfe.111.2021.03.30.01.58.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:58:57 -0700 (PDT)
Received: from [10.0.0.17] (218.80.79.188) by
 HK2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:202::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 08:40:45 +0000
From:   Haojian Zhuang <haojian.zhuang@linaro.org>
To:     Hao Fang <fanghao11@huawei.com>, "sre@kernel.org" <sre@kernel.org>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] power: reset: hisi-reboot: use the correct HiSilicon
 copyright
Thread-Topic: [PATCH] power: reset: hisi-reboot: use the correct HiSilicon
 copyright
Thread-Index: AQHXJS+jiVlA9W11uE+RPaeN3QHKyaqcNlmA
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 30 Mar 2021 08:40:48 +0000
Message-ID: <PH0PR06MB7560EB9D65A4CF06F6F5C0A3977D9@PH0PR06MB7560.namprd06.prod.outlook.com>
References: <1617086285-36565-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1617086285-36565-1-git-send-email-fanghao11@huawei.com>
Reply-To: "haojian.zhuang@linaro.org" <haojian.zhuang@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 06
X-MS-Exchange-Organization-AuthSource: PH0PR06MB7560.namprd06.prod.outlook.com
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id: e3aea8aa-daf2-4fa5-c100-08d8f3578406
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-clientproxiedby: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To PH0PR06MB7560.namprd06.prod.outlook.com
 (2603:10b6:510:50::12)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
x-tmn:  [Uy7Thh/wUSziR3uoac2f0LHqtu3KKXNR]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD12282F87BF8C498ABD3FD608B1785B@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gMy8zMC8yMSAyOjM4IFBNLCBIYW8gRmFuZyB3cm90ZToNCj4gcy9IaXNpbGljb24vSGlTaWxp
Y29uL2cuDQo+IEl0IHNob3VsZCB1c2UgY2FwaXRhbCBTLCBhY2NvcmRpbmcgdG8NCj4gaHR0cHM6
Ly93d3cuaGlzaWxpY29uLmNvbS9lbi90ZXJtcy1vZi11c2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBIYW8gRmFuZyA8ZmFuZ2hhbzExQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvcG93
ZXIvcmVzZXQvaGlzaS1yZWJvb3QuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
b3dlci9yZXNldC9oaXNpLXJlYm9vdC5jIGIvZHJpdmVycy9wb3dlci9yZXNldC9oaXNpLXJlYm9v
dC5jDQo+IGluZGV4IDBiYTVmZGMuLjVhYmM1ZjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG93
ZXIvcmVzZXQvaGlzaS1yZWJvb3QuYw0KPiArKysgYi9kcml2ZXJzL3Bvd2VyL3Jlc2V0L2hpc2kt
cmVib290LmMNCj4gQEAgLTEsOCArMSw4IEBADQo+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb25seQ0KPiAgIC8qDQo+IC0gKiBIaXNpbGljb24gU29DIHJlc2V0IGNvZGUN
Cj4gKyAqIEhpU2lsaWNvbiBTb0MgcmVzZXQgY29kZQ0KPiAgICAqDQo+IC0gKiBDb3B5cmlnaHQg
KGMpIDIwMTQgSGlzaWxpY29uIEx0ZC4NCj4gKyAqIENvcHlyaWdodCAoYykgMjAxNCBIaVNpbGlj
b24gTHRkLg0KPiAgICAqIENvcHlyaWdodCAoYykgMjAxNCBMaW5hcm8gTHRkLg0KPiAgICAqDQo+
ICAgICogQXV0aG9yOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbGluYXJvLm9yZz4N
Cj4gDQoNCkFja2VkLWJ5OiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbGluYXJvLm9y
Zz4NCg==
