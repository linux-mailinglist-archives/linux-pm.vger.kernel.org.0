Return-Path: <linux-pm+bounces-39829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBACD8829
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 10:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E670130037BD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A5322B7B;
	Tue, 23 Dec 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMPhEjjH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069C30E0EC;
	Tue, 23 Dec 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481095; cv=none; b=o96Xu1Gm9ayCHfJh5nnmDaRn4GDtlcO8qMSOpxfO+0RIIFGJ1pUQzmZxBhYVp4BpsD7H5xdcIodc1hci+tjXc72wui7HrbZPayT/lZ2SVy7CsCpnEjwLRtoRpJcWy0uvWemMwDyBS6nJBkaOuRldgnoPsu6ngpyKE7pOqiuGGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481095; c=relaxed/simple;
	bh=ZqET7JDJuYMJb/LzrDvFXdLIdbljPg9n/EknE9F/unk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zgh0huL01GQ/a7P3+wapnbMcdfQYwS7O9xTCXhTCTOly7NK3huwFr+Lghe0k97ePwudg38D+HRJQWbJv8vQUccZhTkGVuOkwh332+3jgcRbXmYtPx795mvtEQ2AKpFDS6l9WA1IdREl8nmBxEjoOj9Pu2WS9pVtni3OtPYTWJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMPhEjjH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN2tDeT1529451;
	Tue, 23 Dec 2025 09:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zBoAtYPh9Xvs4dL1yvk9zQSK
	y93obHuhGl8rTezuj5M=; b=BMPhEjjHJZvNP4JVGCTyrcKBhKHBxRgTjn0VKYkT
	L0MDjw6o0ronPZX43X8RXHs40eN/qwL60huL5nirefbr6cv4l6l//8aD/MZbKV0V
	TBnP6XqUi2fdJKHcBzP1gVksd+tzJQlu1jDJjvReeddeBKYV8oiuxGW+c/8RGnPI
	DHNJOsN7gW9nctyZ8x64bAJkloxdUyJdCYBOodCwF3PHH01uJ/sgt8Uu+MXen281
	GH8fVcBTI+PnK0LqF00xKx/vBUyM/uhs1l4LSzaLNC38vR4xoGW44oBAp/NXUOWg
	4RiRi/tpTJjfAyjXbHhLxbq2x9T98k0UidZHZAW4X+ccWw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y3a23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 09:11:29 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BN9BQjB002134;
	Tue, 23 Dec 2025 09:11:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4b5mvm77vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 09:11:26 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BN9BQuc002129;
	Tue, 23 Dec 2025 09:11:26 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 5BN9BPLU002127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 09:11:26 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id 223B0AB0; Tue, 23 Dec 2025 14:41:25 +0530 (+0530)
Date: Tue, 23 Dec 2025 14:41:25 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, fenglin.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] power: supply: core: Add SiLION battery technology
Message-ID: <aUpcvT1IKyfxr7xb@hu-kotarake-hyd.qualcomm.com>
References: <20251124-add_silion_battery-v1-0-3c86b70d2543@oss.qualcomm.com>
 <20251124-add_silion_battery-v1-2-3c86b70d2543@oss.qualcomm.com>
 <aUft_bUIhiMJF_2A@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUft_bUIhiMJF_2A@venus>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=694a5cc2 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=aV-ZtTf-xQq4tOraWO8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: nNLGhhH7BXUTH2HnSzIyuck3rey-LWnQ
X-Proofpoint-GUID: nNLGhhH7BXUTH2HnSzIyuck3rey-LWnQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NCBTYWx0ZWRfX8r4rDL4wp12V
 W5WahnRR0p7f9Xiz5CHao8lO/E1j9ro1BT4SBvllnZ8oRplOF5dVZDCc2/VGSVlsRP5mAM9BLEm
 5HkO1MlVxuGUEGNlDb9JkAwb1KicLs6DPOa31u9Cm6kf4HN9iqKKzWRNIG7JmSK91Af7VubLodE
 NtmV7IGomfAZUR8emRmNCF6bRirdQe86J6b/2dl6H7kR7gm0aJwSa3uE+7KQEZfZmKRqdugbfQV
 Xr7FD4u5Ntnx0vYm5RhVNEINZov+obF/UvI1VAabBemyaCN+F9DeXrxwFsYIxDWB/59/vxGftoZ
 NrR86dlXhNT6n67V1Y1j1p4wpUR+fXqv38CfMZILiU6MdzL3JQ3lf0xJOHVr0PEdyIzvUIulC30
 IERpd0IG7CWskRwIGLRDW9B9nM5p+N+KGWLhfpX4YbUH0+HgG5Q4fGxlgT149VTJHUktd7si2Aj
 JtGbL4kQTHcyLLD5H9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230074

On Sun, Dec 21, 2025 at 09:57:01PM +0900, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Nov 24, 2025 at 04:42:41PM +0530, Rakesh Kota wrote:
> > Add support for lithium-ion-silicon-anode (SiLION) battery technology
> > to enable proper identification of devices using this newer battery
> > chemistry. Without this change, such batteries would report as
> > unknown technology.
> > 
> > Introduce POWER_SUPPLY_TECHNOLOGY_SiLION and update technology
> > mappings across core, sysfs, and test interfaces.
> > 
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > ---
> 
> The change itself looks good to me, but it must be submitted with a
> user (e.g. an update to the qcom_battmgr) as a follow-up patch.
>

Actually, we do not have any changes in the qcom_battmgr driver or in
the device tree related to this battery chemistry technology text.

The battery chemistry is obtained from the charger firmware, which runs
on the remote processor. The charger FW shares the
battmgr->info.technology value with us, and based on this value the
power supply framework derives and prints the corresponding battery
chemistry string. There is no local hard-coding or DT-based battery
chemistry mapping.

Best regards,
Rakesh

> Greetings,
> 
> -- Sebastian
> 
> >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> >  drivers/power/supply/power_supply_core.c    | 2 ++
> >  drivers/power/supply/power_supply_sysfs.c   | 1 +
> >  drivers/power/supply/test_power.c           | 3 ++-
> >  include/linux/power_supply.h                | 1 +
> >  5 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index 4b21d5d2325136be65126d4d1d6e64608280fe44..1f42e6f138ea8ae0fe8c232c38d0ff6fb20180e7 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -525,7 +525,7 @@ Description:
> >  
> >  		Valid values:
> >  			      "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
> > -			      "NiCd", "LiMn"
> > +			      "NiCd", "LiMn", "Si-Li-ion"
> >  
> >  
> >  What:		/sys/class/power_supply/<supply_name>/voltage_avg,
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > index 9a28381e2607d650fa9b719b683af375bb118fad..385ab8aa7e69f3f804e7ac0ee3782446f18e2c3f 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -677,6 +677,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
> >  			info->technology = POWER_SUPPLY_TECHNOLOGY_LiFe;
> >  		else if (!strcmp("lithium-ion-manganese-oxide", value))
> >  			info->technology = POWER_SUPPLY_TECHNOLOGY_LiMn;
> > +		else if (!strcmp("lithium-ion-silicon-anode", value))
> > +			info->technology = POWER_SUPPLY_TECHNOLOGY_SiLION;
> >  		else
> >  			dev_warn(&psy->dev, "%s unknown battery type\n", value);
> >  	}
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index 198405f7126f96a57a549cd1ecb9b71089b9c3d0..f2a5ec519b2ef60fb5ede101ca461d899218e186 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -122,6 +122,7 @@ static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
> >  	[POWER_SUPPLY_TECHNOLOGY_LiFe]		= "LiFe",
> >  	[POWER_SUPPLY_TECHNOLOGY_NiCd]		= "NiCd",
> >  	[POWER_SUPPLY_TECHNOLOGY_LiMn]		= "LiMn",
> > +	[POWER_SUPPLY_TECHNOLOGY_SiLION]	= "Si-Li-ion",
> >  };
> >  
> >  static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] = {
> > diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> > index 2c0e9ad820c0db23165758303a16bddac1a1634b..64bd4a1147ca06566a909513a80760ad707a8605 100644
> > --- a/drivers/power/supply/test_power.c
> > +++ b/drivers/power/supply/test_power.c
> > @@ -437,6 +437,7 @@ static struct battery_property_map map_technology[] = {
> >  	{ POWER_SUPPLY_TECHNOLOGY_LiFe, "LiFe" },
> >  	{ POWER_SUPPLY_TECHNOLOGY_NiCd, "NiCd" },
> >  	{ POWER_SUPPLY_TECHNOLOGY_LiMn, "LiMn" },
> > +	{ POWER_SUPPLY_TECHNOLOGY_SiLION, "SiLION" },
> >  	{ -1,				NULL   },
> >  };
> >  
> > @@ -733,7 +734,7 @@ MODULE_PARM_DESC(battery_present,
> >  
> >  module_param(battery_technology, battery_technology, 0644);
> >  MODULE_PARM_DESC(battery_technology,
> > -	"battery technology <NiMH|LION|LIPO|LiFe|NiCd|LiMn>");
> > +	"battery technology <NiMH|LION|LIPO|LiFe|NiCd|LiMn|SiLION>");
> >  
> >  module_param(battery_health, battery_health, 0644);
> >  MODULE_PARM_DESC(battery_health,
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 360ffdf272dab86241f1aac4650d1a91a088a84b..04996037219d5a22d2b2a7f136e5d3565a4507ca 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -83,6 +83,7 @@ enum {
> >  	POWER_SUPPLY_TECHNOLOGY_LiFe,
> >  	POWER_SUPPLY_TECHNOLOGY_NiCd,
> >  	POWER_SUPPLY_TECHNOLOGY_LiMn,
> > +	POWER_SUPPLY_TECHNOLOGY_SiLION,
> >  };
> >  
> >  enum {
> > 
> > -- 
> > 2.34.1
> > 

