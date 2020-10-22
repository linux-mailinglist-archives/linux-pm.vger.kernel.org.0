Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD5E2965DD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 22:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S367994AbgJVUQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 16:16:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:22285 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S367982AbgJVUQK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 16:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1603397767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khqhyXkq9FqrDhR0zj2Ls/cxizFuEQpsBpag30NOVtc=;
        b=eZdN77CL3kM3edHIc66La6vLYNtBSfB9Y7yRIVY2Kg1XEgS5r2pXsFsukeMkqn8Xh6vo43
        /Xuf5/vCjPnScl9hA8AiNL/DRb+axLYR34d4Zl3A+NbHyv63Uc48BiOV/d4rdqlfaAEsad
        W42Ey7fp7HH0rXOeH+zv35+xcW3+z28=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-G_C3Rag-MzOlVVjC17dc9g-1; Thu, 22 Oct 2020 22:16:05 +0200
X-MC-Unique: G_C3Rag-MzOlVVjC17dc9g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js9TlemXgJ93qHlFLw7Sc9BcBagHlO1rUGMGYft0gMKU2EEHVTWqRKNgHgmPPndx92+iVAu8Sl81Yn8Rj5BZCxpx+LXvo4+3qhT7RTHN35/2MXwAPEv3VDKBuRgB65ymMNN4qoFQFC75I0F/ltAql403aky9YI0fWGCoN6lMqzWnM3hvXbEVsJeD2bv9rmlWX+JRJkrkn11X1FR5whYs34dGag62jVu5C/OF/6QBkl3y/y918sWvDygU/u/cN8TcKnoSp8Cjr4AQz9dolEcXHuJkguyu+1sJF5agQkCESXIFnwFEzcZ/ssyivqcZDFOlLv+ZLFBjHS/Idyg4gXn55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khqhyXkq9FqrDhR0zj2Ls/cxizFuEQpsBpag30NOVtc=;
 b=IalCLXzET8N6Fc3zBOH/Ibv2Ltu4omLPJv8APTddXy/HE0/6oypwfqg2XoFL48lllMrCuKSrcvOZYj8rKIULmpWaN0+3M8E4HC5qSuj73nXlilwW+WNvlBum0q0q8G5zyr37J0Fu7t6bQEB0PfIOuHnqY1/bJZ2bLphKDIxKkJSuRr7koglKKqR3un1ZnWmzBBGxkSiRtgY7WsEabz7Fkgdhy4wo57BKhhknsJj9N9vzfU5Xwrn48NkvgVHiL3BmxJV6M9jx4WkfN8zaYHl0HEKoJVxkEOea9C88OHSmSMSiKZssjlZz7wqvErii8RpaYlhhRCEef10JDtNgy+aEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28)
 by AM9PR04MB7715.eurprd04.prod.outlook.com (2603:10a6:20b:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 20:16:03 +0000
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::29a3:4b8b:de0:7f3c]) by AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::29a3:4b8b:de0:7f3c%7]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 20:16:03 +0000
Message-ID: <1603397760.16275.49.camel@suse.com>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle
 core
From:   Giovanni Gherdovich <ggherdovich@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Date:   Thu, 22 Oct 2020 22:16:00 +0200
In-Reply-To: <1603397435.16275.45.camel@suse.com>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
         <34115486.YmRjPRKJaA@kreacher>
         <20201022120213.GG2611@hirez.programming.kicks-ass.net>
         <1790766.jaFeG3T87Z@kreacher>
         <20201022122949.GW2628@hirez.programming.kicks-ass.net>
         <20201022145250.GK32041@suse.de>
         <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
         <1603397435.16275.45.camel@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2a02:830a:b003:a100:70cf:f004:73cb:aa82]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM0PR04MB4530.eurprd04.prod.outlook.com
 (2603:10a6:208:70::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:830a:b003:a100:70cf:f004:73cb:aa82] (2a02:830a:b003:a100:70cf:f004:73cb:aa82) by FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend Transport; Thu, 22 Oct 2020 20:16:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dc93f86-705b-4632-4853-08d876c74ce4
X-MS-TrafficTypeDiagnostic: AM9PR04MB7715:
X-Microsoft-Antispam-PRVS: <AM9PR04MB7715559EFE9F1042902AB141931D0@AM9PR04MB7715.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Tgg31TVRApzqCqIQOpUmqaUO1zblvW9O3VMgMvQ4DykivcYRwLu6oL/zXRQ1Pn4pHT6a1xkBE10XHDPFdagH9zKHiPt6wEKeu6BJQY75xny8BeyNpxkRTNY2Nrq5KQRpggnqv1eiCwNAf5r13ix1sVMSmm+cDwd/nDZhIkFgldupTkESNP9muM99v5XwLYWZrhSR6l5TKqiLsW5aAQXn1JjSkFO22xIrIqqLXUvSmDD5cSKlBURYPntXdXt9Xnre5w6Yio7JPWzFW9Xp1E5Pnb1azrEhsTQmkP2FmWGZ8jwN3ThlUXSoJZpBg6nk1e0ETLOLxkQ7wcQaJ3OXMvOIrTJ6adY2KPQA4Awvb4YlsYo4jfyaISpBPAU6rXAhhbT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4530.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(136003)(39860400002)(66946007)(8936002)(54906003)(6486002)(16526019)(478600001)(316002)(110136005)(4744005)(66556008)(103116003)(186003)(7416002)(66476007)(52116002)(4001150100001)(83380400001)(2906002)(5660300002)(4326008)(36756003)(8676002)(2616005)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HehTq9JYz/ctr75T/XlbC4yp83FRRcxfREKgcHm5ZQ8TOoV2JNUsRltgyJCyEyXbek0KYZzEIt67er2WiBheD6SA2unrzDgI47a2xTgOqfoXa5cKUmBN6rtU12mGpT6BbgPZk6dP+PrfueysnKnr4iwdKqdVQ2CTK606lNTxqRhWLStyDyFOkfpBwmwxLQk5st7urEZQ4j03e2BYZvH7l4HQ3bcPjPatPaMjlgC9AwCHRpAYqAZkF7XLAWYPtV2Npj0Q5xwJ4DuosLSe8lHAd48FXIRXRzu6Drkbvkp29E05aeU8sEWa/OOrn7HJ9t+4GAZhlWdv/oSXtVu3pcGqNixsUlxWSi4Px4sNN6xHk9bEPWyLxEyR8ESkUk3EjNygbZO42Wh5fK5LbFq3HPE0tzAwMUtxz8LOSwL0SqEPSFfqgcVaMTOGpn0LHg9Y7qoBtyT5YUD7DHa+iA598LIgwKgRkzEg4adyfDSHhwTqIYebQxKEVsf3ZE8l4TFSkQls+O6ruUJciPfBe05Wu2BrCez9nUFE7LxllXZWSTR0bKhCQUpyJRf3hVDLnHUQ8B1uX87deWYk2tlURZVxJn38eaMA8L648mAuzRzr4jQLzKRhFLrCTaYxPQPqqqZDMPRjT2xO1LuN/QpnfaMM0WH+OCbiGr07G7nsNsNNRGdbWJtR67kxdCdY8dr9HakbzQp4Kct/QFxlA0lgXedWv9nVUw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc93f86-705b-4632-4853-08d876c74ce4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4530.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 20:16:03.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gUReJ0U3HcuitVWfgnFP/nC3EiuoaRcSGXkFfXAzMJRtmE/8oWOu2fdN6oxBX/aAjK1s5YWqFp4A8vhk4OpAcYwnoE0PC1vRDJuDh+e8ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7715
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-10-22 at 22:10 +0200, Giovanni Gherdovich wrote:
> [...]
> To read the tables:
> 
> Tilde (~) means the result is the same as baseline (or, the ratio is close
> to 1). The double asterisk (**) is a visual aid and means the result is
> worse than baseline (higher or lower depending on the case).

Ouch, the opposite. Double asterisk (**) is where the result is better
than baseline, and schedutil needs improvement.


Giovanni

