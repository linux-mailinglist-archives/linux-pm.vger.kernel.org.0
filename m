Return-Path: <linux-pm+bounces-29846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1452CAEE120
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F61D3A3CD3
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF128CF5F;
	Mon, 30 Jun 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="VJzX0orP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2010.outbound.protection.outlook.com [40.92.18.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807228BAB3;
	Mon, 30 Jun 2025 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294041; cv=fail; b=TT5f+q4+F1/aDXwCTsaFoZIgITHGAPE5+XDp4jCV84ssuOMhg6wq/CUIvfJywc3Pl0WXcCTc4ntzHb73+vO8OndP/BoHjlJs3st7k5REPFMzN0IZ9Y+AY+nbaFSCT9a1nplsFRoCZeD83pcHECrVO1ujoro85S1kOAR/hfATPHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294041; c=relaxed/simple;
	bh=PUu7/eVZdhqea0gGp/vqFqJTdlGx9xqw8xRAHTQwWcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nw2CiJ4sxktTF0AUJXeYQwcL1Pt/38/iJq8iq52enfjBW6Qw4lpztg0OYwO2fQei46O0FlIcza4inwwuSk+Y9wiLWOjNZiWEf6cW9VO6z5Gs5OxWZtIeZPwpKX0sVHXG+CqLPGwl0Wh9M7zlZbpt8LSbEQ5GzuXrFYp6EBhitLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=VJzX0orP; arc=fail smtp.client-ip=40.92.18.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNHJzhpQ20zCz9DlhssMWvq3qNt1KK2sdRkePpjcR0mzhccLMA+YOIz2/uWxzZdZLrQ/aYykMqANCPMUiN8TI+rBOB9LqJhsCUpNIAIrgKJTDsn9/rb6+Rf0ODNfS8hf5fN0qATjyu5ZmZqhEBWaYV5oXQ4Q7Hkr5ndafK97LAAmGRNqq7WkwYYa2oMssuy+DQUBdl6cXzhqcE9K+PeDOI26H3fDeUagZHTLSniZgRpA7c27BqE3cJFG5VkSLTwazWoyfRyidxtrva+bp9p4iX5yloSRj5h01FmAqbSb/H1PONqE0oymXEFOe4AtH1ectGs44GNKvGIt2G9RNeG3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUu7/eVZdhqea0gGp/vqFqJTdlGx9xqw8xRAHTQwWcY=;
 b=fNXKQKojLIPPMK/7wZlFx6lXnZVXsMGyGAgC2kqleurHYRxQz7dEXU/k+GOZzBuBaNQYGAT1Fxv0+k00xYFyQZMmnd1lPTwbKlWoT/Y2l8jBxJwlKgsuWROK3jOM38uNCjaEwBJtrCNtRd6/IVLRLgxdqdnjnWYuVoZET+cjQXNv7MVsQ0Q+4t8cT/8iur2Vf+eVjODXGCwESmMlmX3nPyrSYyrXQ7XMTKZFRh7s0V8yI9Fxqnl/h29N/F1xHZU6AxD+0lXYzxT9UqtdApRY09TsFnahAHHNJyvxUbxItSOmIRGIwVzfukbqixezVihIQPpv+2RuzxXyDpOfY+Nm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUu7/eVZdhqea0gGp/vqFqJTdlGx9xqw8xRAHTQwWcY=;
 b=VJzX0orPZM6rTsTxwFnEaKouViH4ls13zUGFhEo8FWMmbZ+slFNhZSjz+ERyMg63effB5La11cr5+RK74fIz86G/rlXNu/c51tILxE5rgtDfJxkcGjQ6JaBpwlFB8ffKt4TC2MTVsU9ZNtOPchH77IOePUOgrozYziEKNXrDAmXPbe4BZ2W3UX3UrrwVs7qrgTyznfdeIb57EIUwlPIxXOYAZf5uceKFlcMRmlFsesS2Wo/ecVrMKP3YfEwfw+3qvXFmYkrq98+Deng7ekbVWkTyY3r7YgNLo3jKesEf1z8JBRoey8cu6ndvXEdOT3c0dv5amJCzhXZSrLfE7529Tw==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by DS7PR19MB8293.namprd19.prod.outlook.com (2603:10b6:8:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.18; Mon, 30 Jun
 2025 14:33:58 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%4]) with mapi id 15.20.8901.014; Mon, 30 Jun 2025
 14:33:56 +0000
From: Christopher Morgan <macromorgan@hotmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Chris Morgan <macroalpha82@gmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "sre@kernel.org"
	<sre@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "lee@kernel.org" <lee@kernel.org>
Subject: Re: [PATCH V4 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A
 Charger
Thread-Topic: [PATCH V4 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A
 Charger
Thread-Index: AQHb5tRd+A1efjZ3pEC79dRe+J4XlLQWlCwAgAU2MAI=
Date: Mon, 30 Jun 2025 14:33:56 +0000
Message-ID:
 <SN6PR1901MB4654D8420C9F65C8BE2D10ECA546A@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250626195343.54653-1-macroalpha82@gmail.com>
 <20250626195343.54653-2-macroalpha82@gmail.com>
 <20250627-lurking-amorphous-elephant-e14c7f@krzk-bin>
In-Reply-To: <20250627-lurking-amorphous-elephant-e14c7f@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR1901MB4654:EE_|DS7PR19MB8293:EE_
x-ms-office365-filtering-correlation-id: e80aa0d0-09a5-4992-5020-08ddb7e32556
x-ms-exchange-slblob-mailprops:
 RlF2DIMZ1qWFvGXy5Wd3ApbRbGaaecD6+PyMtvFaSpm66Q0Bn6IqA/VJJVY8mE1lIH2WnmH1Vkilec+PiO1ozfddXweZG3+kgpe1RmJsn3tJ8rSPhOxQg+THxW9yZYW3iXYAb3+hiVqrM0iwT7zg5W7Q2TdV+LcUzNRHs9j5aYDOOMo8qnoMqm5a+kCNdeEtMsGlprmOyFr8rxXWBqGjpAT3AK0YvZqdq/sBZn+Lc04qFqU4RlccOH4UacEF5OPNgCEHh2Qin9W0itVQ6z25obfp5hcezpqvW5WSAGdG+qwF9slbGfh77/nnmxRuL4+EHI5R1GV5NmDudRHkSzprpfO9dn3aszGBE1q/7Bo7ER2rO8jiaWHKWVZ45xHq2QnhE2LITGJMmyHJuCk7+KR9yM7JRZ9ZPYPD+oz7Yx842rOtl2wbWPfUyJHk+Ac7jg5SKxfALFY2X6mBJP81EkvKxARERX83FXDNJNuokss4MfJ7aqhd4A6ns8N+Om3ANUnbzSlnO4YEbWNlMnSXehD1cwPI4lwjQa25guIlPtRONFnYM/f/8LIGnVs1Md55mYb3EWTk/l6eYIEGMKUWXDdW4UaCmyEUBNzkcTFPeI3BTlvY/5A76aXbkexStql8xM8rgwux9rG0+at8JPgzZKrJj+Y7I7vU0TErdL96z4LI1WBNFDQQEmjx58zIyaLPogLHdQa0PU3j3Mv1Yy3+cr+Q07hi0QveQghIquuAnWXBEcoqVVeFAEkAqxuH27nFm1TedoE/cp4E9zJnun5HE3qau1mha4st1IfvOYjwA+wmg3XxY+dUFmr4ZXpb7XkKwfvRM/LAR9WNP20sEePgWLsTNrHNvvjH1E1g
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|6072599003|19110799006|8062599006|8060799009|15080799009|461199028|440099028|52005399003|40105399003|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkpKcGQvS3lkajFPbmVBdTh6ekpYU0V6Vzl2Y295VmxHWVA2dzlCZ09TSXJT?=
 =?utf-8?B?eGhmdGxwQ0pqSjRuSFExL0dYZ0U1cXFSaWtwVktwcFZYampRb0xteW43UTJl?=
 =?utf-8?B?TVVvbE5uLzNFcmY1MUg4NU9PcGZIUEc2eXlpd3o4NnQwZ0JPd3ZLK2ZVS29r?=
 =?utf-8?B?c0lkbllmK2diaE5Kb3k0ZlBaZ1dWY0tSQWRlWnYwODRJOUMvTWZXNXJqOGE1?=
 =?utf-8?B?SHlSYThOclBsODEyY3hSbkVqblYzY1pBTUtEKzdHbi9hdzl0WmJBWEhueUxX?=
 =?utf-8?B?OXNRa0pqNy9TcDBobjRzRVpRaHV6MlhacHY0bEExVmxrQmp2STRnNEpiQ29l?=
 =?utf-8?B?aGgyN0NDOHJJWGxQWEZQamJTKzd4S01rMXY5cDg0eklzaVhoK0RKLzZ1d1My?=
 =?utf-8?B?cGptZ3luY2sxcW9mNnp2aEJTekp1TG55U1Y1ZHZjcmE3RGR3WFNuNFQzcmJt?=
 =?utf-8?B?SkpmN1JiK2xDY0NrYjZEZUZScHFPeUlWWlA1eDZDTjBNQkFQbzVhSTR0RVNF?=
 =?utf-8?B?ZmlVVjJLTHF2dW53NEswQzV0UzNDNUgrTkNqc0VLeFZMd3pUelV5RmxMVnd1?=
 =?utf-8?B?WUM0Sk9VZUhRTVlISEtqRTh2K1pNQUNOM20vYVQzK3lGWkE5WVVaRFo0TU82?=
 =?utf-8?B?RTIyTStXU3BQcnVld1RmdUxJOFNpWHg4UkZkQnBrczFTckZoOU4vaVZ4TDhE?=
 =?utf-8?B?Yy9OaDN6ZE15ZjFJUjhRZEdKOUlLNXdxN1hlbHk0WkV4TS9ZRGNrcHJOaU5k?=
 =?utf-8?B?MFFkTzRkYnloZEd3Mm9pUUJGemJ1ZnovWlI5RENCeUF5YVFQVmxpbUNvc0NE?=
 =?utf-8?B?TXZITktyd3RVVmdveE9ITFNFaXZ3YzE5ZmRRODdmN3o2eUNJUnQ4ZUR0SUp0?=
 =?utf-8?B?SHM2cVdPZ20zdVhsMkF2c0l6UHFvMk8zMGJkcVozNnY1RmErbFJ4Y2JZb2E3?=
 =?utf-8?B?b1Jqa3EzTGtMOHlkcTVBRUpaVDRDQkNUVXFKdTM4OWNaWXE4ckZSVVdHOUF1?=
 =?utf-8?B?QTdvek8vZVNUSGV5T1BreEtuWTNkRDBYUU5GdjhsQjJwMmNpSWVKelJ3TXlG?=
 =?utf-8?B?SWc5ZHFsL2VwTVFvdFpzdHl0MEMyT25UNkhtbjlpV2tpa2FHWXhxVWhZYXU2?=
 =?utf-8?B?MFpCd25wR0VLSUF2dnBHMCtCVDZYZjArSkFhc2tpYmN6K3hVNXhLUkYwN25E?=
 =?utf-8?B?UCtMM00xc1RhTUNEOTlDVklpZk9tUUtNSWg0dzNRRkVidXhKVHpCS0wzQS9G?=
 =?utf-8?B?OEdlaHJyR0JjNkdjY1VMUDdKQWNXTFFZUkZzeWpkWWhZQ1YyTnozL2hLL2tB?=
 =?utf-8?B?SWxBeVJudmVsTDZTcm92aWljL3dFN3lvSFFhWDdXMjB3UG9sNjltclRvUnBK?=
 =?utf-8?B?dGd5elJuV1NKTm83L2VNUkpBaDdHdUdmbGJPUzlZb0NFd0JXQUpsMkVmQzFY?=
 =?utf-8?B?YlIzanY0eGZFcmUyaExwWUZNZ2dyWU5WZE9JYTZaKzBvc1kxYXhKenNNUkJH?=
 =?utf-8?B?ckt5dFNIbldCdm91MURFUkJ5ZEI1NDUrL1QvdzRmMkpsVmtPYmZVVHNtbVh4?=
 =?utf-8?B?SFdVamRBdy9rTkZDYy9Ha2hvUzJCTE5RS1FMSStJaXYycUF3MnBtbE5EUDY5?=
 =?utf-8?Q?CR+Oj7RDqQjiRpSoIk7Wqi4Psp4c82Phlr5d7Wi+s3g0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFFrbkRJd2pCdVhLUHc3blBqSHdFWVliK1VhdTBuTStRNy94UHhoQktGS3dI?=
 =?utf-8?B?N04rVXJjVUdyaFBrMldDUWxjb1NvNHFNbVNkYWVFcUJqWG81ZmNoa3ZYbzdU?=
 =?utf-8?B?Zy9wOWNnOGFta3gvRWQxQmluMW5xVEp5a2pWRFpsYkpuaEp3cmNaajZCZkY5?=
 =?utf-8?B?T2tHU003bS9FOUx5WGdlMHNNbVlJZXJ6eDBtUlBSUGp4SUlTenNSZFE3OHVM?=
 =?utf-8?B?L3RZQ3FqSzhnS0VLdFVUM1JuZFJSaGtFL1N4MldYcXdKT29ncm1oa3VXdVc5?=
 =?utf-8?B?VW9HTm05N044aUJqSmVQN2FudVNUN0RhUnRYNXVFWGlGckJKR3lkamNodVhQ?=
 =?utf-8?B?a1d1Z0MzTXZDTDdFWThhbjlReVJoUHM1dkVCRWlYSmc3VU5GeWFjcEJ0c21r?=
 =?utf-8?B?YzdpRWtIMWRNMnpGQlJvLzRQKzVMc3lNVmlIbVo3N3cxUVF0ZzlXZ1JQZHNO?=
 =?utf-8?B?cTFEWjk5WDczZUk1cVd0Rk1iUGxmMEhKQjM1alNuRTYraE9PcmNibzdnTmpI?=
 =?utf-8?B?YVRhKy9SUWhEZXVTMEdXVlVkNGRaQStvamNCemlCQWVFbmZvaDZydERFU3Rw?=
 =?utf-8?B?ZlNFMURwSTBQQW5ZakF5TUUxN0h4azQwOWpPM0duekZvSmNrNExJdXlkOU5Y?=
 =?utf-8?B?UHFOTjBEK3JyTEVXRlFBejMyc1gxQjRtWlIraG5BcXN2RkFCZnM2MFdJRDhG?=
 =?utf-8?B?bTZhZUxhTFFjejgrMC9LdStvQW1LdHBKdFhBUG1mdFRSWUVaMUZmY0o1cEtB?=
 =?utf-8?B?NG9xY2pPLzRXWk5RNzF4YW5kcFZ0anFocitycDJyNVNLd1FjOU5ReFhYNkJj?=
 =?utf-8?B?ejFnVkJqeUdUVjV1SHk4REx2Z2I1b01mQ0s4TThucXdVZTNCY2tZWTFBakRp?=
 =?utf-8?B?STJQZWdlK3g4d1JWQXhkUllBd3VBbFNCcHNJQWxEbDMzMEpYZU1YRGdvNER6?=
 =?utf-8?B?UVd2RnowdXROdjFKOXVUZnhNQlVtK3dZRzlHRGFqa2lRczJsbW0yaEJyMWdK?=
 =?utf-8?B?dVFzaTBoZGU5SEVKUlhPenhwK1ZJSExCM2xtREZZQTJiTHF5MjI1eFBtOUpv?=
 =?utf-8?B?ZGlFS1BsVjVmYlhhcnY0WmY5K1pEMldDc1VRVlA3UkVZc0xMU0hhWlRuTUZQ?=
 =?utf-8?B?ZUJQb3pUQWtUTGZMOFhZdkRwbm9kR2ZXdmJFQmlmMEk1R1VzWCtUdWhGNjM3?=
 =?utf-8?B?V1B4cUdiOXQvbnhhcXBSSkdIcUdzbnkrTFNrbW5qNjYybkRSM3cvMm1kdWd6?=
 =?utf-8?B?K2ZxZVhxWjZsY1UwU2p3bTFHT254Wjl5SURJUTBGK1NLenEwa2dmOTJENEFX?=
 =?utf-8?B?cG5GM0d0aHByTVQzaU1lQkRlVnp4SURBZ3hDRytmOUdDNHR2VTZCVHJONi8z?=
 =?utf-8?B?eENQMm5iZzc3WlV5ZWU4SVdMWi92aVlha3pFOTdBWmp6Vjh1U3Bvdys0OFh4?=
 =?utf-8?B?L0p1T0ZnTDlrdHArcnhoM0JiRjlielJZZnd0SHUzVWNWa3NRRW5KSExlR29E?=
 =?utf-8?B?Mi9TYWV5aXluaHJYdk5DZjdFa0lYckZTSkxyV3NPS0lySU1aRDVnaWd4QkJj?=
 =?utf-8?B?ZGwvaHlDNDVmWStMb2c2Q1hobUhiSG12QW9sRUxjeFdJQTN5RlM3emRCbnAr?=
 =?utf-8?B?TEFQeFNsaTRSQXhzdm1URTRlV1ZZR3MrMzhwQ3VGZDh5S21lMXBZU25ORjFX?=
 =?utf-8?B?YzRnSUJCVEVOMTBULzYvb0N5NkJSNXRFNUI0MGFyalF0NUhaVHFjS0k5TCtD?=
 =?utf-8?Q?pJlCWXibyjONXDkAWA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e80aa0d0-09a5-4992-5020-08ddb7e32556
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 14:33:56.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB8293

DQoNCj4gT24gSnVuIDI3LCAyMDI1LCBhdCAxOjU44oCvQU0sIEtyenlzenRvZiBLb3psb3dza2kg
PGtyemtAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBUaHUsIEp1biAyNiwgMjAyNSBh
dCAwMjo1MzozOVBNIC0wNTAwLCBDaHJpcyBNb3JnYW4gd3JvdGU6DQo+PiBGcm9tOiBDaHJpcyBN
b3JnYW4gPG1hY3JvbW9yZ2FuQGhvdG1haWwuY29tPg0KPj4gDQo+PiBEb2N1bWVudCB0aGUgVGV4
YXMgaW5zdHJ1bWVudHMgQlEyNTcwM0Egc2VyaWVzIG9mIGNoYXJnZXIgbWFuYWdlcnMvDQo+PiBi
dWNrL2Jvb3N0IHJlZ3VsYXRvcnMuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIE1vcmdh
biA8bWFjcm9tb3JnYW5AaG90bWFpbC5jb20+DQo+IA0KPiBEaWRuJ3QgeW91IHJlY2VpdmUgdGFn
Pw0KDQpJIGRpZCwgSeKAmW0gc29ycnkgYnV0IEkgdGhvdWdodCB0aGUgY2hhbmdlcyBzdWdnZXN0
ZWQgd2VyZSBzdWJzdGFudGl2ZSBlbm91Z2ggdG8gd2FycmFudCBhbm90aGVyIHJldmlldyBzbyBJ
IGRyb3BwZWQgaXQuIEkgZGlkIGxlYXZlIGl0IG9uIHRoZSBvdGhlciBwYXRjaGVzIHRob3VnaC4g
SWYgSSBzaG91bGQgaGF2ZSBrZXB0IHRoZSB0YWcgSeKAmWxsIHRyeSB0byByZW1lbWJlciBuZXh0
IHRpbWUuDQoNCj4gDQo+PiAtLS0NCj4+IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC90aSxi
cTI1NzAzYS55YW1sICB8IDExNyArKysrKysrKysrKysrKysrKysNCj4+IDEgZmlsZSBjaGFuZ2Vk
LCAxMTcgaW5zZXJ0aW9ucygrKQ0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvdGksYnEyNTcwM2EueWFtbA0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4N
Cj4gDQo+IDxmb3JtIGxldHRlcj4NCj4gVGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGR1cmlu
ZyB0aGUgcmV2aWV3IHByb2Nlc3MuDQo+IA0KPiBJdCBsb29rcyBsaWtlIHlvdSByZWNlaXZlZCBh
IHRhZyBhbmQgZm9yZ290IHRvIGFkZCBpdC4NCj4gDQo+IElmIHlvdSBkbyBub3Qga25vdyB0aGUg
cHJvY2VzcywgaGVyZSBpcyBhIHNob3J0IGV4cGxhbmF0aW9uOg0KPiBQbGVhc2UgYWRkIEFja2Vk
LWJ5L1Jldmlld2VkLWJ5L1Rlc3RlZC1ieSB0YWdzIHdoZW4gcG9zdGluZyBuZXcNCj4gdmVyc2lv
bnMgb2YgcGF0Y2hzZXQsIHVuZGVyIG9yIGFib3ZlIHlvdXIgU2lnbmVkLW9mZi1ieSB0YWcsIHVu
bGVzcw0KPiBwYXRjaCBjaGFuZ2VkIHNpZ25pZmljYW50bHkgKGUuZy4gbmV3IHByb3BlcnRpZXMg
YWRkZWQgdG8gdGhlIERUDQo+IGJpbmRpbmdzKS4gVGFnIGlzICJyZWNlaXZlZCIsIHdoZW4gcHJv
dmlkZWQgaW4gYSBtZXNzYWdlIHJlcGxpZWQgdG8geW91DQo+IG9uIHRoZSBtYWlsaW5nIGxpc3Qu
IFRvb2xzIGxpa2UgYjQgY2FuIGhlbHAgaGVyZS4gSG93ZXZlciwgdGhlcmUncyBubw0KPiBuZWVk
IHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1cHN0cmVhbSBt
YWludGFpbmVyDQo+IHdpbGwgZG8gdGhhdCBmb3IgdGFncyByZWNlaXZlZCBvbiB0aGUgdmVyc2lv
biB0aGV5IGFwcGx5Lg0KPiANCj4gUGxlYXNlIHJlYWQ6DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y2LjEyLXJjMy9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1p
dHRpbmctcGF0Y2hlcy5yc3QjTDU3Nw0KPiANCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBw
dXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQo+IDwvZm9ybSBsZXR0
ZXI+DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KVGhhbmsgeW91LA0K
Q2hyaXM=

