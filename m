Return-Path: <linux-pm+bounces-42491-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cutvDH08jGlyjwAAu9opvQ
	(envelope-from <linux-pm+bounces-42491-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 09:23:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2CC122305
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 09:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9DC4300E730
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E7343208;
	Wed, 11 Feb 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3qhWzVH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9B21CFF6
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798200; cv=fail; b=gtLaINknt73BRn2Rbwz60ozGwlzmknlElYqoWONJddCqU3B1Jf7bNacNbJGkZlJo90HKE26n1kU+oZ/aFmbVu7JuqWwcd8Ju8SNQqpPkAnMkKLVl4slBz+1IN8Pdngtv2Umnivogcogws/llR5N7klrbYqcz1Z/m7Cyx4+vQDI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798200; c=relaxed/simple;
	bh=WJzdnLbUA6FIg3SJk8uIiQlEcYspzWGGEGiHY7JhT2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtTJd/shoX+JjWtCq1IcbRu9Rkekg06UbkDwm9RF0dcOKbbwjjz0CRosfkkvQFUxtm3g2WrsuAi4ExmkpboAmGe9KMT8+jitRwJLz9hjMTC2jMlxmXRnaSzMKoA3Wrl/5X0YiA2wur7g0ZtwPYkz6+XKMuo/rnZeYjVmZEulB+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3qhWzVH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770798199; x=1802334199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WJzdnLbUA6FIg3SJk8uIiQlEcYspzWGGEGiHY7JhT2I=;
  b=X3qhWzVHaLF7Z8tOwBmfAfQTTs+9v6JlXPCzmwWX78/EAFxPHJ8u0wfi
   mem3wG0bU8o7GuAS7BTPkEeN7xOWt0kpWzhEd4gViND9SCPpXlH7S5DaM
   wbXAp3TU9TIgUFVZZLGOsZyJZlOA6wtX8NcKl74/wPksG/4aTB6++Tr4Y
   2CXMgxzWr3i5BynVcKET9UCLZ0si/X4MikL9ogswPHmbYNV9beYltEwtb
   7sKTIkPCi9h0HSpaR4RlfblpJBg7g1SEgD5EjnahOHhm6cQB6YHsK8Wmv
   XaTk2l7ijOPCoUslb5RmsDrzKWEpokbmSFHDHWCqjXGLovkGeUZMarGzO
   w==;
X-CSE-ConnectionGUID: HGuy69wvQX+pchoklDEdHQ==
X-CSE-MsgGUID: EbSafe7uTimtZGj2C8LhlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71926043"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71926043"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:23:19 -0800
X-CSE-ConnectionGUID: vSs+ClmlRbK+66/CIwYnOQ==
X-CSE-MsgGUID: nscrylq/RmalRbyVcb3fYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="242002643"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:23:18 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 00:23:17 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 00:23:17 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 00:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUcKJ8nUf/nnOqks/B3hzX//MLwRoTqCBVziGyJc96vHXMBtkXu3WFj8coGl5AW/p+q3tWxwNHQdQitiNk0LG7mBDNSrlL71hQRSRCYFMsRzD0eAxrM8/eVXqpxiYmAEUyWOeRSmYPpUh46ibMRpBfaeB3X9/mPZo3N+CdyOxW8y7nY3p45ubChnly962qvfhAWkR42jqTazqHaRHVrISvygSzTxjoYxU9L6Yw1udlLXWC97E+h2cZAHVuBoJxS0LA4BX56RBIupiVtJFUGJuXEN3W9I6icBGsctCoTnymop99ZzPzZVrEjR0pZZC8yxkSHNkt0v9SYukRCYu4OOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra86IcuoF10JD2Cb1Dm3DbhsC3W7sPIxM9pfgcU9e7k=;
 b=MR65U2qzbnRsJfNFXmvF2NNMGcZVTwycn9+S8dbPYzffYwXeItC3OyR1k+NaCKrnzV5gtO0+YYW94oeFgW18E+odoep+/voC50h9zWLvwGz1SJ5Y0Yv1wvnIrrZj7xeTr56Ke+1RvGcIvmQYBnn27A7qzqe5nGZqEytk3V2A2HACBksJJo+FCaCn9EjCK+QwSLdUZwysRMVlshn9WI1cAQ+0pgFEnkn7Th1gIZ5DY6Jyx+NxYMEge30p4oNhv/DBvsS8YAwxUxsiuWK5g4fropgJH1Qn1Vc/5aNO3ILcGrIKEzEtlA4bAIk/J3YMb5i7J6XPVy2ktLopDVmUkqWkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by PH7PR11MB5960.namprd11.prod.outlook.com (2603:10b6:510:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 11 Feb
 2026 08:23:15 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 08:23:15 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "Zhang, Rui" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, srinivas pandruvada
	<srinivas.pandruvada@linux.intel.com>
Subject: [RESEND, Cc only] RE: [PATCH] thermal: int340x: Fix sysfs group leak
 on DLVR registration failure
Thread-Topic: [RESEND, Cc only] RE: [PATCH] thermal: int340x: Fix sysfs group
 leak on DLVR registration failure
Thread-Index: AdybLyiK1BN8PyLjRlypZFI+++50tQ==
Date: Wed, 11 Feb 2026 08:23:15 +0000
Message-ID: <LV3PR11MB876881B77D32A2854AD2908EF563A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251215054538.3483331-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251215054538.3483331-1-kaushlendra.kumar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|PH7PR11MB5960:EE_
x-ms-office365-filtering-correlation-id: bc75b22b-2c87-430e-2b09-08de6946cdaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?KbJ/f8MBWZoKMpO67fPXFPuOEDxD9ZQT25BEiie3t0hLzbDtkS3pdgwOGlNd?=
 =?us-ascii?Q?Sq6O8uHsgwwNL67MPhmGGMs/TwEnxevcXjbfr+ur8/mGLoafVHiIFi/yJqE+?=
 =?us-ascii?Q?jhywXBcqXyIUztSVBgzMAnWTogx2J7OXVeFAxEIahHOGF7wxxBHINgvepoaw?=
 =?us-ascii?Q?l7b7xAjvja4HNWfNA8nOkxfGJTbCirn7atXuf2JV1cvnttX8yIZUrqhY1dE/?=
 =?us-ascii?Q?tYIK/yduwJ47dWLyg2B5YTFWQ83JnikTB2y5Em+wjVjoUt4abX8SsUKxVW1l?=
 =?us-ascii?Q?4IUKKVrZoCzO5kUI2kz2nI3rklWNF2MhcC7Gwk1gEcdaPUXwo6CE/lyz4nfb?=
 =?us-ascii?Q?uPPtfdf6+AUyb3df0CQ85j7DZTDkvrcQuhP8+BtF+pPPlv2qzjEnSaNdrp9U?=
 =?us-ascii?Q?1bWiABqyf5QsPDHUL5oP+8lPaBIyM/PRBSLFE1p5YVuHBaPIzUqYf3TiD664?=
 =?us-ascii?Q?K8QufctT2HsIeoctvrpUkM1y8v14mkl32CvO7bk+qB/FV2eHoLrIShrpwVS3?=
 =?us-ascii?Q?3D0DNtGAvCKqDvZ1oeqbaNPt+nN1TMQ3weQX+DzVZCQI8mqr3MNKRKnZ52Nh?=
 =?us-ascii?Q?z1VdVTs/hur+qTOJmWdcP/CgpJLU3Q7aYjQ6kRxDu3AipFGdiAPr20q36Rvg?=
 =?us-ascii?Q?O5JwZ7cLjo+a1N1y8mY0RZ9o4jwy+cF3oTXGlgGxwpSj/4V0SgraLeaC4lCk?=
 =?us-ascii?Q?jAS8lAMlOFIbP0wNLPztZFl6nqvnQ8DI6ydzmJYqpBDB4EAMQyOopx1Ke4J0?=
 =?us-ascii?Q?Pgjlfa51a/hJPtBkqbCT1Yh+zMWHbtSGoCvyc1zqIwYUY/U7aqVjb9nIa/pk?=
 =?us-ascii?Q?snJRLEHXlyM2l6Y42hh765E2/utlP8qpPZe/dK3c+wGX9q0p/aewD+zAibgr?=
 =?us-ascii?Q?pnEqgUXlJ6o5D7HR65cnEs2aHVr3wV8LpjovYOSexTmIVpC7CZKSAr1VgT1t?=
 =?us-ascii?Q?2E9YOIT0ut/WKFMhgLby7xm1prF65dFMRIFJ0UWJnfkevSzKvABTO1c4X96t?=
 =?us-ascii?Q?X7x77Z+pvi2LjhKfhHKMjcoKSC29jiRe34U4sv9q7tfET5Jz4qMjI9HRRQC8?=
 =?us-ascii?Q?32LtJtts455FOSuKXoAjQjw40qPD/UKhjw0bxrUEX4hHQohc2S6/Pau3jAkQ?=
 =?us-ascii?Q?eX5CHLSnX/XSrvIp9Oy48fTf0t00fP7LczHoWKacZwyws2jvHS0l474iYNdX?=
 =?us-ascii?Q?M/YIpagtuXkMm4uhSRNE4O3mvm8wRLlAY3ggRKB+H8c5lpIPJ970Y57tSJXt?=
 =?us-ascii?Q?JM+foqloOXASDFKdJhZCkDy5eK9P7ynkFakxLMaBR5jfkoin5D2EREX2YQA6?=
 =?us-ascii?Q?WdPfZ+yw10jmp+XTfcmZXH7TQlEzddu3ixpI8trX1+ChpX7753KBKo3T/pO/?=
 =?us-ascii?Q?dLNDAj5SAzXCAe//4nGdgxrMynxc/QTx3Ik0nDu81lYUhp36SQLzXu4wGULL?=
 =?us-ascii?Q?FrroZWcmAq2KAk094YG4LXh2bEtLEe1TRYbFrNw44j9cK5LD6IoN4JYFL9ke?=
 =?us-ascii?Q?5a0cwMmen0pZ/L2YKN2BR7h2y5v08+ILJdsL+8TD/7YRTr0I84PbiDM+ZQ8k?=
 =?us-ascii?Q?vTKQZextBi5+jljiCrhsNTvqdfNswAX/UPIoAGR0phiJ319k0BBUNZP2j8fl?=
 =?us-ascii?Q?GBlwvP6JziTIjBION79Ihss=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?emjbnqsZsQAZfBERLwwEkeLlqkGe2htuSBUs5T2taMfKeegSEWnwFwZ3+vrq?=
 =?us-ascii?Q?+4vZmr4DYjInLO10yPJnpj/UfEu6AGwZXyjHr93ZR+EUnDu3GJsY/pb2xdvn?=
 =?us-ascii?Q?qAY2vB9IMGyd1ky/EACCI/TT5NOm+t6ni4WJUsaxbcHVIA2j20N5NjbCfrBG?=
 =?us-ascii?Q?4237YtohG6oP7yl0HsDwBxq8Qf9x+5c5RDhbHsaGHudpxwJVhJvkzACybOiQ?=
 =?us-ascii?Q?5SrQe87Slp7dxGtwIEi3hjUIrn6MmIsM3ak3TkVScmx3CEk4yO9leQHw5Ew5?=
 =?us-ascii?Q?jCyHsWLTHRE1LVBNjx+d9MsMiH2SG6ibIYuonDIbi9xXmvZqTNIri9K5XAxd?=
 =?us-ascii?Q?5HMsgH8NosrkbmMexyEy7Gvb5Zy7jyULlCCZvhgst+iPi39NsngTJmGzMcwQ?=
 =?us-ascii?Q?cPXgWR2cXviEB29ULhF4h1RXxAcA1GlkTRwNyTLM83v5pbJW7peNpLZsBLUG?=
 =?us-ascii?Q?5J937CXIEfVKwqSGSf8ZDW0pK6yPC+aEUhppNJOpbH/iivhXW14YL2PPuZFW?=
 =?us-ascii?Q?fW0eBWBwIBdl8xZweLJSoRRJY1GenlVCklXie8viRYDQnWWrHTiXF78ph5eb?=
 =?us-ascii?Q?J8ZP7rbYVDl3txsngAVUafP/fJKc5Npu2eLCo9m5RV1BOCkU2HiFYgyzp4aj?=
 =?us-ascii?Q?7uNtUcxqW3fLnAbSHK4xJV10rEx5QcA50yLZFGaKeoaDTKUGGOwdDuynuo+N?=
 =?us-ascii?Q?KofS0Tw/ddPIqUpRpW85s9agWjGPSwGOtEqCl0An9/KB68YHf6NWrRN5ZL21?=
 =?us-ascii?Q?WeDV/47vnZ37L2PvN7AeFrQzsG8eQVmC0HeCViuWVpAsHXc8jSmz18sv4jSt?=
 =?us-ascii?Q?4eMRwC74geiMcJ/fNT6LdP5NUquyCDpDttskP6Av2o0IahnyrvI8VtMTnvyR?=
 =?us-ascii?Q?AqiSxATbraRFZuymIJfXGtY7wen61LtLcpltF3iT7NkoAF35rGWWoYIce+Co?=
 =?us-ascii?Q?jBl70dGkpoOodvT3vIwF/HvYSpgCDUSmWeIaIRIUCtIoGZFybX4UTv/x994H?=
 =?us-ascii?Q?IQEN0k0uZxDbnAZFJtnTBuoegsR/J9md4aqlHhgOSgjYXhugzJXt821AKchM?=
 =?us-ascii?Q?UrwYqspS94OKOaC8VBHVuyCaNA7U4SJR1Hoh5zn7mirbzncNmCGLETnlF2ua?=
 =?us-ascii?Q?pi3Me4edBXY/r9z8mr+xhVBfKouM+ibEkg6Bm0A8qrIG1lKnHWwBlBfcWwGk?=
 =?us-ascii?Q?ZDjzaX72v7YdK1gLedb0EbDJCpwl/I+LAr3vx6HZpFGzLuhltFo5rPf8it8q?=
 =?us-ascii?Q?lS72FHqECcZ0+aiSTWGpovPl0mt6mgzNI9KZx3jBM+bQgQoZQcT+A91a+9ME?=
 =?us-ascii?Q?UEqmurx1QAnr0GOZWvXqyfxS2D592+Fg/0dadXgJCrI4iD0VzU3bGJBJSvcQ?=
 =?us-ascii?Q?SpgDlnmE3TDoGOkXNXQDsZs06lBdvsklgAAcs3nDRoriuvc8H3XEUWATMggR?=
 =?us-ascii?Q?Bzwur3ANr/S9dBzhVi0W7AUcMBvIQ4DCfBmsSDN6xlG65HoGQ00Xht/dXjpc?=
 =?us-ascii?Q?SY5FexP0qJXe/1gM+TUOFph/Lmf51sv4elABn53duwSEeHk8eiX0s6m0HmKH?=
 =?us-ascii?Q?oVcHNRG7mHWb3K5I2EhG0DFrPhzsUjk/WcJ5UA/hHPrJ0Tq9v7zEPmHs4++a?=
 =?us-ascii?Q?ZVh9U/prv8UoMZ4Uw+pBFOVqVIOOAF9YzhhCaJUA+Ei95MOvgNEMPkHcGu0L?=
 =?us-ascii?Q?C5Mk4E2qBp6F2hBEocjshu9rJ7Q/qOZZhXD9zbbdJIIQlPVXLL5jX+qPQrK2?=
 =?us-ascii?Q?2DdWLL2EEQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc75b22b-2c87-430e-2b09-08de6946cdaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 08:23:15.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtHlRzB3YtrJa1rI3VQP1bRSztzeCad1KX82rmocxiqJwwePNGFBvxKqm5oXusLnUvoXf5HdgPQEH1bKHNr2E3bQstbI51Bt3UqHWkuytNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42491-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linaro.org:email,arm.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6B2CC122305
X-Rspamd-Action: no action

Adding Cc: srinivas.pandruvada@linux.intel.com

No code changes.

Original patch: https://patchwork.kernel.org/project/linux-pm/patch/2025121=
5054538.3483331-1-kaushlendra.kumar@intel.com/

-----Original Message-----
From: Kumar, Kaushlendra <kaushlendra.kumar@intel.com>=20
Sent: Monday, December 15, 2025 11:16 AM
To: rafael@kernel.org; daniel.lezcano@linaro.org; Zhang, Rui <rui.zhang@int=
el.com>; lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org; Kumar, Kaushlendra <kaushlendra.kumar@intel.c=
om>
Subject: [PATCH] thermal: int340x: Fix sysfs group leak on DLVR registratio=
n failure

When DLVR sysfs group creation fails in proc_thermal_rfim_add(), the functi=
on returns immediately without cleaning up the FIVR group that may have bee=
n created earlier.

Add proper error unwinding to remove the FIVR group before returning failur=
e.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 .../thermal/intel/int340x_thermal/processor_thermal_rfim.c   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c=
 b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 589a3a71f0c4..ba88d878c998 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -466,8 +466,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct=
 proc_thermal_device *proc
 			break;
 		}
 		ret =3D sysfs_create_group(&pdev->dev.kobj, &dlvr_attribute_group);
-		if (ret)
+		if (ret) {
+			if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
+				sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
 			return ret;
+		}
 	}
=20
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
--
2.34.1


