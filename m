Return-Path: <linux-pm+bounces-43714-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JUBBfv5qWncIwEAu9opvQ
	(envelope-from <linux-pm+bounces-43714-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:47:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43B2189D8
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E93803053CD4
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D91435F60F;
	Thu,  5 Mar 2026 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GeBv2aHN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WyNkzuMm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894933987E
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747197; cv=none; b=eedHPzlgYZrxqe9cJX77o5WyGAEYwNrxuXP8y8O18RxZyXrMTEpUqdgNBjFyYhcftaeoJYHH62zX8kKTB2bvVoECJIl7gUBy+pc5ZboXJj1g6MFp1mSNmhoHOpWfrFRslMnkjJPXKyQj9YhnMvY5Su1I9PgysgLNOqPBzyfbCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747197; c=relaxed/simple;
	bh=GLZGLUI6y8mTC1CoUCYnqXy51nlJ9FI78lkz9mC/UlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Awcsb5IWeCXGKz+S5/cYv1lsvaGeIXxEhdem2Glme4sQVPShWzo2DsfTEL4g9IgMF45jOy/VT9Z31d1m4+IUN3ImA+kcg9CxBlb0rs9DmmoHKEB/UU75/65poc42Mg5Y2muhka4aDKG1MaMWQbducnY+n2HrEjC2+K3Vrlt20rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GeBv2aHN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WyNkzuMm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625KmX0v2267218
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 21:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xpMBKCSvSSCJ6d7tlxcLy1pZDHIoGSHsADWWql9ZdpU=; b=GeBv2aHNVvKJuPtt
	eqOaebwXuSQyRXKB14SiCirL5sWi0kFlG7GjQG2PGoGLP5iNIdRwlb2APnrLD29V
	AcWpBx+LDgm4Ns9G5c5nNRz/Bm1VOy/z2inACLoaXG84LKgsYo/AwHUh3izX/eab
	u5T9A6Ww+RUQ76gVcYzTGMEqQifcJorocpBhrICD+UHOdQkIS+q13LQEWyQh+HKa
	2Lo1uTq+1Q5MFjbfzsZVmjzeCaHNdhWGCW1InUj+W5iwk4Z8Far4fEmkpAz5ZZlm
	Ay7u7UY/xudN8LiOczLN9xi8YOXCgWCPKbEPaLfJMl3wusZurk7q9rmRR6J+XD8q
	v2yp0w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380u82j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 21:46:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70fadd9a3so913690785a.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 13:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747192; x=1773351992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpMBKCSvSSCJ6d7tlxcLy1pZDHIoGSHsADWWql9ZdpU=;
        b=WyNkzuMmH3Up5uwbUGZLtnsel2tR5xSDWM33k1k6KEMF8Vq9qWkL4LvMTO3UzP8Md/
         bUg65h7TOfGx7adR7x1NO5umEEx2wOL+FDhgMN1UpQE1OAMmqmPuRIPoXe+ygByUbwtK
         J89nhBYSqI6cpiUPlqSyfWU0BAPVomQ5841MQ82JPJ7Yf7UYxMaa+MtBJaT7kcfahrZi
         FgKu4C78zXXJqdWEs/Cge9oMRiD2QPLc/Kk/SlsZosyDpQh+Ydr4RJ/COs+Clrt/JIs6
         o9jEX2eQvULdssIjtAQ8NNRDbuENqLiqkkVyRiVVkyWur8c8nHjVABPIZhx7kIGpOMnY
         pffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747192; x=1773351992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpMBKCSvSSCJ6d7tlxcLy1pZDHIoGSHsADWWql9ZdpU=;
        b=N2jXIKWDhr6UyBfs/J23l4q7yfcL9cGR5j07nP+5abAlzqRzADNbBGpECsy853+k+n
         don8saoe5OasvNS+LYinTolvEkB3pGGU98co40DhGjtOSsJKuITJsxm39CRPUPuoQuCj
         nKLUlOiuoTQN9okQXUPjvmgi7ZeOZttTRL3SSRRXwxuWdemClRFmc/kwvGX/zkpeAkf0
         9sSz1NrWPiIBXxHxBjH+9jGBO08LtmwsWtbK3Ij3yqFMTaPAmgU9pIoMEhd9MxWB80BU
         fF5zJ+2kgtgmxCSOloiFdarCE0QNik7VCMWOW4F7QJNHtrrgp0cw531839eHwYyUthHy
         5FLw==
X-Forwarded-Encrypted: i=1; AJvYcCU+U7nH4f+B2U0Ld9lXgtfV+HCajyHx8r+hnOuVaMu1Rihdf29me6YrmePJ7yU2dcpf5fIqxWmE+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AJNmWI4XprtA6VocEVUnN66psk3TsJ22FK2m8vNjUvlt+URP
	bEERDz3wMHtZ4dSecdeh8bX3eFjgNUptlqTZAmesjPeEzopJtH2GZVVzxsuJK0sFFpuJmdvfe0G
	0Va6ZV9Q9uqatkRJT6FTVwBj/wzzT442SB34v0Z9pS6l6tMIKDkp1EZ7Z0tJXow==
X-Gm-Gg: ATEYQzylZ1zUPqNJAII+/agvl5T7IVBqlwGoUru6/Cd2S9wWOsPHbkmtAslR/d/HmLR
	xB3KayXfjbyfm/uCUMtFu0ctNWGnWI6ZwrcV/fSTslW1WHyosIP6xVE35KI2H3lYWkqqRiEthsS
	I8GnnOS5vS8FQT5RBeBGk/qD7hfvYQBJlMmLQpa2Yg6q7w5pOrT0PDL79gz5tFNSZFWTMTPXHm2
	6LsVKOYZRcv4z4p0nsgEOSuR76GsLlz22Gyi7HnsDI0MmV7CeVWa+rXM6lzvRb1ex1+PVp9L/Hj
	YAe4IkSkWqqHfzGfkJftRpM2ehG640edmdb/3Sb81QiDhaQdhQi1iXIcT9gKaVqtjwFHTleAQxy
	KqtitrrXkwdhbaND50xo76kzKWUCYWK1Fz0k4M89rSU4t
X-Received: by 2002:a05:620a:470d:b0:8ca:3ed2:175c with SMTP id af79cd13be357-8cd6d4cc1camr1440285a.43.1772747191600;
        Thu, 05 Mar 2026 13:46:31 -0800 (PST)
X-Received: by 2002:a05:620a:470d:b0:8ca:3ed2:175c with SMTP id af79cd13be357-8cd6d4cc1camr1436485a.43.1772747191067;
        Thu, 05 Mar 2026 13:46:31 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:30 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 22:45:46 +0100
Subject: [PATCH v2 07/10] mfd: ezx-pcap: Drop memory allocation error
 message
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-workqueue-devm-v2-7-66a38741c652@oss.qualcomm.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
In-Reply-To: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, driver-core@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GLZGLUI6y8mTC1CoUCYnqXy51nlJ9FI78lkz9mC/UlM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmeJzlU8gtQ+4HiL7LX4Fy8K19t5RszehHhz
 SdtprdfKQWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5ngAKCRDBN2bmhouD
 1+uJD/9YHgJPFhEWQZRYuFGzeWe8z/r5Tj5iDNybutQ6RysEUkerwdr2pHTgfsRQ//1RBXmWi4/
 cGOD0AGUW3fLq4SM0ozdgKVp4SGjHe5iS324Xf1SGuW4PJtLu0+DMjDrfZ9Kh1ya+NqtjLYuctz
 EwrBWEFLt253pIx8JCBgt1U9C6IW+kSFzgE0q/6wqJA4aWn75PrcCxhf2XrRd6gNe80PoXhkOmd
 iPj9TycFnCTENdm1LWjcEsZRyEROU5nbnitPogh3z/3ryvudV27PKHPdqL/LKiQpefeIln5miV5
 ykVaKnRr187X1a0M6VOJWFeleyCQwr4MXqY4dHZnwAwm2mzUoSfV/+72TagqkdYkAtYsXcGEnp4
 qwXZqkweTKfvInlQcX+MyS6503tvm1UMD6Q2kjN2gSX82uO9lbiHdSpFRU093QPrKuJupoShmdh
 c+IRyPPixT8vJaH4ptL0qsHeVwM+TK/12/SQ7fPsshy9snxcABFZ0LKXOo30Nt2gevOrIolUsGX
 PNGgDwpP5Mj32fue94/BZgfPd3GFsPgp+6L/76kAS7UKVXl62a9ZGQ/jZEwxiu0d7y3zwBnCiYL
 sOSc37AP/ai745h4xjt63Iu8AQz/MLguOCoJxLgCfbcrRpy1BlqgAR349lUqdkuRtqt7TOnBopB
 uVBAFJuWvfRWAFw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a9f9b8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3HoxRS3-ReI3PdwluWoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: HYyF6RQglSOy49XsIuAvA75zdDBmzlvm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfXycIoTnjAY+GH
 jMv8fVhS5xbv1/9JIoAA9/SrwFl2kE81CCtoWP9UCN1bgUnokUDAXp2TriWfXjv3eSKSPWsEion
 +2ENpwtLI1Ixe0zkbSyvjp37pVhk1EccE412SO8gzP4zXK/rm+QTlb8yXXZYoSG5IBVyyqbZ32Y
 a6xMKhWTOmqCfJ2PNPLoNUkYmRJEh7E6qRNDf+GXk/oWS4t+feNMc9QZYg5L29f9zpVELCjkuRj
 w5e5fKjGE2MdUHLGj37Kqh4OGypRTk0KW6rxXMzZPowwprsn93vt/Sda10FMz54NOYHndcZRa5b
 iEbugdEAeh3Vmx+A2QY7kyX+b3AyQQ+PuNopMjeGAfRr5r7Im1C6IPozmGrrZ1Pvh7mjSEllxHB
 Ft/GoNiJXDgxOI5vaTQnVaFlyEIqpyc/Q5cQKMcbc+hKJ6n++ntQu/exnPKxmaTzAFeJAh65wXD
 7Ci2yfspGyymURnx65g==
X-Proofpoint-GUID: HYyF6RQglSOy49XsIuAvA75zdDBmzlvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050185
X-Rspamd-Queue-Id: 7B43B2189D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43714-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Drivers should not print error messages on memory allocation failures,
because core already does it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Further patch depends on this one, thus it should not be picked
separately.
---
 drivers/mfd/ezx-pcap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 24ca140d6a48..cd0520a08224 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -416,7 +416,6 @@ static int ezx_pcap_probe(struct spi_device *spi)
 	pcap->workqueue = create_singlethread_workqueue("pcapd");
 	if (!pcap->workqueue) {
 		ret = -ENOMEM;
-		dev_err(&spi->dev, "can't create pcap thread\n");
 		goto ret;
 	}
 

-- 
2.51.0


